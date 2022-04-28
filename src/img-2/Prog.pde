void setup()
{
  size (800,1000);
  noLoop();
}

void draw()
{
    MyLib mylib = new MyLib();
    PImage img = loadImage("280.jpg");
    PImage aux = createImage(img.width, img.height, RGB);
    aux = mylib.EscalaCinza(img,"green");
    aux = mylib.Brilho(aux,17.4);
    aux = mylib.Sobel(img, aux);
    aux = mylib.Media4P(aux);
    aux = mylib.Media4P(aux);
    mylib.Limiarizacao(aux,1);
    mylib.Preencher(aux, 45, 30, 255, 0);
    mylib.Preencher(aux, 40, 100, 255, 0);
    mylib.Preencher(aux, 5, 55, 255, 0);
    
    PImage original_truth = loadImage("280.png");
    PImage comparacao = createImage(img.width, img.height, RGB);
    PImage recorte = createImage(img.width, img.height, RGB);
    comparacao = mylib.Comparacao(original_truth,aux);
    recorte = mylib.Recorte(img,aux);
    PImage original = loadImage("280.jpg");
    image(original, 0, 0);
    image(original_truth, img.width, 0);
    image(aux, img.width, img.height);
    image(recorte, 0, img.height);
    image(comparacao, 0, (img.height * 2));
}
