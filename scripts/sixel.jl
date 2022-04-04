import Images
import ImageMagick
import Gadfly
import Cairo
import Fontconfig
import Sixel

p = Gadfly.plot(y=rand(3))
Gadfly.draw(Gadfly.PNG("a.png"), p)

png = Images.load("a.png")
Sixel.sixel_encode(png)

io = IOBuffer();
Gadfly.draw(Gadfly.PNG(io), p);
pngio = take!(io)
buffer = IOBuffer(pngio);
ImageMagick.load(buffer);
Sixel.sixel_encode(ImageMagick.load(buffer))