void setup()
{
    size(1000,1000);
    noLoop();
}

void draw()
{
    MyLib mylib = new MyLib();
    PImage img = loadImage("v.jpg");
    PImage aux = createImage(img.width, img.height, RGB);
    aux = mylib.EscalaCinza(img,"red");
    aux = mylib.Brilho(aux,16);
    aux = mylib.Media4P(aux);
    mylib.Limiarizacao(aux,190);
    
    PImage original_truth = loadImage("v.jpg");
    PImage comparacao = createImage(img.width, img.height, RGB);
    PImage recorte = createImage(img.width, img.height, RGB);
    comparacao = mylib.Comparacao(original_truth,aux);
    recorte = mylib.Recorte(img,aux);
    PImage original = loadImage("v.jpg");
    image(original, 0, 0);
    image(original_truth, img.width, 0);
    image(aux, img.width, img.height);
    image(recorte, 0, img.height);
    image(comparacao, 0, (img.height * 2));
}
