void setup()
{
    size(800, 800);
    noLoop();
}

void draw()
{
    MyLib mylib = new MyLib();
    PImage img = loadImage("21052.jpg");
    PImage aux = createImage(img.width, img.height, RGB);
    aux = mylib.EscalaCinza(img,"red");
    aux = mylib.Brilho(aux,2);
    aux = mylib.Media4P(aux);
    mylib.Limiarizacao(aux,160);
    
    PImage original_truth = loadImage("21052.png");
    PImage comparacao = createImage(img.width, img.height, RGB);
    PImage recorte = createImage(img.width, img.height, RGB);
    comparacao = mylib.Comparacao(original_truth,aux);
    recorte = mylib.Recorte(img,aux);
    PImage original = loadImage("21052.jpg");
    image(original, 0, 0);
    image(original_truth, img.width, 0);
    image(aux, img.width, img.height);
    image(recorte, 0, img.height);
    image(comparacao, 0, (img.height * 2));
}
