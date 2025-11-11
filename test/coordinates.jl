import Test
import Mads
import Proj

const TOL_DEG = 1e-5 # ~1 meter at mid-lats

Test.@testset "StatePlane detection and transform (ftUS, NM Central)" begin
    # Albuquerque, NM (approx)
    lon0, lat0 = -106.6504, 35.0844

    # Forward to NM Central ftUS (EPSG:2903)
    tf_fwd = Proj.Transformation("EPSG:4326", "EPSG:2903"; always_xy=true)
    x, y = tf_fwd(lon0, lat0)

    # Detect with unit hint and NM bbox
    code = Mads.detect_stateplane_epsg([x], [y]; unit=:ftUS, bbox=Mads.NM_BBOX)
    # Accept either NAD83 or NAD83(HARN) ftUS codes for NM Central
    Test.@test (code == 2258) || (code == 2903)

    # Transform back using explicit code
    lon, lat = Mads.transform_stateplane_to_lonlat([x], [y]; epsg=code)
    Test.@test isapprox(lon[1], lon0; atol=TOL_DEG)
    Test.@test isapprox(lat[1], lat0; atol=TOL_DEG)

    # Transform back using auto-detect, constrained by NM bbox
    lon2, lat2 = Mads.transform_stateplane_to_lonlat([x], [y]; unit=:ftUS, bbox=Mads.NM_BBOX)
    Test.@test isapprox(lon2[1], lon0; atol=TOL_DEG)
    Test.@test isapprox(lat2[1], lat0; atol=TOL_DEG)
end

Test.@testset "StatePlane detection and transform (meters, NM Central)" begin
    lon0, lat0 = -106.6504, 35.0844

    # Forward to NM Central meters (EPSG:32113)
    tf_fwd_m = Proj.Transformation("EPSG:4326", "EPSG:32113"; always_xy=true)
    xm, ym = tf_fwd_m(lon0, lat0)

    code_m = Mads.detect_stateplane_epsg([xm], [ym]; unit=:m, bbox=Mads.NM_BBOX)
    Test.@test code_m == 32113

    lonm, latm = Mads.transform_stateplane_to_lonlat([xm], [ym]; epsg=code_m)
    Test.@test isapprox(lonm[1], lon0; atol=TOL_DEG)
    Test.@test isapprox(latm[1], lat0; atol=TOL_DEG)
end

Test.@testset "NM zone helpers" begin
    # Central
    lon_c, lat_c = -106.6, 35.1
    t_c = Proj.Transformation("EPSG:4326", "EPSG:2903"; always_xy=true)
    xc, yc = t_c(lon_c, lat_c)
    zc = Mads.detect_nm_zone([xc], [yc]; unit=:ftUS)
    Test.@test zc === :central

    # West
    lon_w, lat_w = -108.2, 36.73 # Farmington area
    t_w = Proj.Transformation("EPSG:4326", "EPSG:2904"; always_xy=true)
    xw, yw = t_w(lon_w, lat_w)
    zw = Mads.detect_nm_zone([xw], [yw]; unit=:ftUS)
    Test.@test zw === :west

    # East
    lon_e, lat_e = -103.2, 34.4 # Clovis area
    t_e = Proj.Transformation("EPSG:4326", "EPSG:2902"; always_xy=true)
    xe, ye = t_e(lon_e, lat_e)
    ze = Mads.detect_nm_zone([xe], [ye]; unit=:ftUS)
    Test.@test ze === :east

    # transform_nm_stateplane_to_lonlat using :auto
    lon_c2, lat_c2 = Mads.transform_nm_stateplane_to_lonlat([xc], [yc]; unit=:ftUS, zone=:auto)
    Test.@test isapprox(lon_c2[1], lon_c; atol=TOL_DEG)
    Test.@test isapprox(lat_c2[1], lat_c; atol=TOL_DEG)

    # transform_nm_stateplane_to_lonlat using explicit zone
    lon_c3, lat_c3 = Mads.transform_nm_stateplane_to_lonlat([xc], [yc]; unit=:ftUS, zone=:central)
    Test.@test isapprox(lon_c3[1], lon_c; atol=TOL_DEG)
    Test.@test isapprox(lat_c3[1], lat_c; atol=TOL_DEG)
end

Test.@testset "Edge cases" begin
    # Non-finite entries propagate to NaN
    lon0, lat0 = -106.6504, 35.0844
    t_c = Proj.Transformation("EPSG:4326", "EPSG:2903"; always_xy=true)
    x1, y1 = t_c(lon0, lat0)
    xs = [x1, NaN]
    ys = [y1, Inf]
    lon, lat = Mads.transform_stateplane_to_lonlat(xs, ys; unit=:ftUS, bbox=Mads.NM_BBOX)
    Test.@test isfinite(lon[1]) && isfinite(lat[1])
    Test.@test isnan(lon[2]) && isnan(lat[2])

    # No finite values -> detection should throw
    Test.@test_throws Any Mads.detect_stateplane_epsg([NaN], [NaN])
end
