import Proj

# Approximate USA bounding box (CONUS)
const USA_BBOX = (-125.0, -66.5, 24.0, 49.5) # lon_min, lon_max, lat_min, lat_max

# EPSG codes for New Mexico StatePlane (NAD83)
const NM_EPSG_FTUS = Dict(:east => 2902, :central => 2903, :west => 2904)
const NM_EPSG_M    = Dict(:east => 32112, :central => 32113, :west => 32114)
const NM_BBOX = (-109.1, -103.0, 31.2, 37.0) # lon_min, lon_max, lat_min, lat_max

get_epsg(unit::Symbol, zone::Symbol) = unit === :ftUS ? NM_EPSG_FTUS[zone] : NM_EPSG_M[zone]

# Resolve bounding box input
resolve_bbox(bbox::Tuple{<:Real,<:Real,<:Real,<:Real}) = bbox
resolve_bbox(bbox::Symbol) = bbox === :usa ? USA_BBOX : USA_BBOX

# Candidate EPSG series for State Plane (NAD83) in meters and US survey feet.
# Notes:
# - 32100:32161 typically cover NAD83 StatePlane in meters.
# - 2226:2280 commonly include many ftUS realizations (e.g., California 2226–2229).
# - 2900:2999 include various NAD83(HARN) ftUS zones (e.g., NM 2902–2904).
# We try to instantiate transformations and skip invalid ones.
function _candidate_epsg_codes(unit::Symbol)
	meters = collect(32100:32161)
	ftus_1 = collect(2226:2280)
	ftus_2 = collect(2900:2999)
	if unit === :m
		return meters
	elseif unit === :ftUS
		return vcat(ftus_1, ftus_2)
	else
		return vcat(meters, ftus_1, ftus_2)
	end
end

"""
    detect_stateplane_epsg(x, y; unit=:auto, bbox=:usa, sample=200)

Detect the most likely EPSG code for input State Plane coordinates (x,y) in the USA.

Arguments
- x, y: coordinate vectors in a State Plane CRS (units per `unit`).
- unit: :auto, :m, or :ftUS to limit candidate EPSG codes.
- bbox: bounding box tuple (lon_min, lon_max, lat_min, lat_max) or :usa.
- sample: number of finite samples to evaluate for detection.

Returns
- Int EPSG code for the best-matching CRS, or throws an error if none found.
"""
function detect_stateplane_epsg(x::AbstractVector{<:Real}, y::AbstractVector{<:Real}; unit::Symbol=:auto, bbox=:usa, sample::Integer=200)
	@assert length(x) == length(y) "x and y must be the same length"
	bx = resolve_bbox(bbox)
	# collect finite indices and subsample
	ids = [i for i in eachindex(x) if isfinite(x[i]) && isfinite(y[i])]
	ids = first(ids, min(length(ids), max(sample, 1)))
	isempty(ids) && error("No finite coordinates to detect EPSG")

	best_epsg, best_valid = nothing, -1
	for code in _candidate_epsg_codes(unit)
		local t
		try
			t = Proj.Transformation("EPSG:$(code)", "EPSG:4326"; always_xy=true)
		catch
			continue # skip invalid/unknown codes
		end
		valid = 0
		for i in ids
			lon, lat = t(x[i], y[i])
			if isfinite(lon) && isfinite(lat) && bx[1] <= lon <= bx[2] && bx[3] <= lat <= bx[4]
				valid += 1
			end
		end
		if valid > best_valid
			best_epsg, best_valid = code, valid
			# perfect match for current sample
			valid == length(ids) && break
		end
	end
	best_epsg === nothing && error("Failed to detect a plausible State Plane EPSG code for given coordinates")
	return best_epsg::Int
end

"""
    transform_stateplane_to_lonlat(x, y; epsg=nothing, unit=:auto, bbox=:usa, sample=200)

Transform State Plane coordinates (x,y) to longitude/latitude (WGS84) for any US state system.

Keywords
- epsg: explicit EPSG Int code (if known). If `nothing`, auto-detect via `detect_stateplane_epsg`.
- unit: :auto, :m, or :ftUS to guide auto-detection.
- bbox: bounding box to guide detection; :usa by default or pass a tuple.
- sample: number of points used during detection when epsg is not provided.

Returns
- Tuple (lon::Vector{Float64}, lat::Vector{Float64}).
"""
function transform_stateplane_to_lonlat(x::AbstractVector{<:Real}, y::AbstractVector{<:Real}; epsg::Union{Int,Nothing}=nothing, unit::Symbol=:auto, bbox=:usa, sample::Integer=200)
	@assert length(x) == length(y) "x and y must be the same length"
	code = epsg === nothing ? detect_stateplane_epsg(x, y; unit=unit, bbox=bbox, sample=sample) : epsg
	t = Proj.Transformation("EPSG:$(code)", "EPSG:4326"; always_xy=true)
	lon = Float64[]; sizehint!(lon, length(x))
	lat = Float64[]; sizehint!(lat, length(y))
	for i in eachindex(x)
		if isfinite(x[i]) && isfinite(y[i])
			λ, φ = t(x[i], y[i])
			push!(lon, λ)
			push!(lat, φ)
		else
			push!(lon, NaN)
			push!(lat, NaN)
		end
	end
	return (lon, lat)
end

# --- Backward-compatible NM-specific helpers ---
function detect_nm_zone(x::AbstractVector{<:Real}, y::AbstractVector{<:Real}; unit::Symbol=:ftUS)
	ids = [i for i in eachindex(x) if isfinite(x[i]) && isfinite(y[i])]
	ids = first(ids, min(length(ids), 200))
	best_zone, best_valid = :central, -1
	for z in (:east, :central, :west)
		t = Proj.Transformation("EPSG:$(get_epsg(unit, z))", "EPSG:4326"; always_xy=true)
		valid = 0
		for i in ids
			lon, lat = t(x[i], y[i])
			if isfinite(lon) && isfinite(lat) && NM_BBOX[1] <= lon <= NM_BBOX[2] && NM_BBOX[3] <= lat <= NM_BBOX[4]
				valid += 1
			end
		end
		if valid > best_valid
			best_zone, best_valid = z, valid
		end
	end
	return best_zone
end

function transform_nm_stateplane_to_lonlat(x::Vector{Float64}, y::Vector{Float64}; unit::Symbol=:ftUS, zone::Union{Symbol,Nothing}=:auto)
	if zone === :auto
		# Use generic detection constrained to the NM bounding box and unit hint
		lon, lat = transform_stateplane_to_lonlat(x, y; epsg=nothing, unit=unit, bbox=NM_BBOX)
		return (lon, lat)
	else
		z = zone
		t = Proj.Transformation("EPSG:$(get_epsg(unit, z))", "EPSG:4326"; always_xy=true)
		lon = similar(x)
		lat = similar(y)
		for i in eachindex(x)
			if isfinite(x[i]) && isfinite(y[i])
				lon[i], lat[i] = t(x[i], y[i])
			else
				lon[i] = NaN; lat[i] = NaN
			end
		end
		return (lon, lat)
	end
end