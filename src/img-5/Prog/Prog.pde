import java.util.Queue;
import java.util.LinkedList;
import java.awt.Point;
import java.util.ArrayList;
import java.util.Collections;

void setup() { 
  size(400,300);
  createWriter("Valores.txt");
  noLoop(); 
}

void draw() {
  //Escala de Cinza,Filtro Media e Limiarização
  PImage img = loadImage("C:\\Users\\Thiago\\Desktop\\Faculdade\\7 Semestre\\Computação Grafica e Processamento de Imagens\\Projeto\\5887.jpg"); 
  PImage aux = createImage(img.width, img.height, RGB);
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      
      int pos = (y)*img.width + (x); 
      aux.pixels[pos] = color(red(img.pixels[pos]));
    }
  }
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      
      int pos = (y)*img.width + (x);
      int qtde = 0;
      float r1 = 0, r2 = 0, r3 = 0, r4 = 0;
      float media = 0;
      
      if(y != 0 && x > img.height/1.5) {
        int pos1 = (y-1)*img.width + x;
        r1 = red(img.pixels[pos1]);
        media += r1;
        qtde++;
      }
      if(y != (img.height - 1) && y < 280) {
        int pos2 = (y+1)*img.width + x;
        r2 = red(img.pixels[pos2]);
        media += r2;
        qtde++;
      }
      if(x != 0 && x > 150) {
        int pos4 = y*img.width + (x-1);
        r4 = red(img.pixels[pos4]);
        media += r3;
        qtde++;
      }
      if(x != (img.width - 1)) {
        int pos3 = y*img.width + (x+1);
        r3 = red(img.pixels[pos3]);
        media += r4;
        qtde++;
      }
      
      
      media = (media + red(img.pixels[pos]) ) / ++qtde;
      
      
      if(media > 117) media = 255;
      else media = 0;
      
      aux.pixels[pos] = color(media);
    }
  }
  //Fim - Escala de Cinza,Filtro Media e Limiarização
  
  //Recorte(Alinhamento Apenas)
  PImage img2 = loadImage("C:\\Users\\Thiago\\Desktop\\Faculdade\\7 Semestre\\Computação Grafica e Processamento de Imagens\\Projeto\\Filtros\\Escala de Cinza, Filtro de Media e Limiarizacao\\Florbinaria.png");
  image(img2,0,0);
  //Fim - Recorte(Alinhamento Apenas)
  
  //Preenchimento
  PImage img3 = loadImage("C:\\Users\\Thiago\\Desktop\\Faculdade\\7 Semestre\\Computação Grafica e Processamento de Imagens\\Projeto\\Filtros\\Escala de Cinza, Filtro de Media e Limiarizacao\\Florbinaria.png"); 
  preencher(260,100,img3);
  preencher(310,200,img3);
  preencher(260,220,img3);
  preencher(180,190,img3);
  preencher(250,190,img3);
  preencher(178,150,img3);
  //Fim - Preenchimento
  
  //Mediana
  PImage img4 = loadImage("C:\\Users\\Thiago\\Desktop\\Faculdade\\7 Semestre\\Computação Grafica e Processamento de Imagens\\Projeto\\Filtros\\Preenchimento\\FlorBinaria_MioloPintado.jpg");
  PImage aux2 = createImage(img4.width, img4.height, RGB);
  
  
  // Filtro de Mediana
  /* Percorre a imagem */ 
  for (int y = 0; y < img4.height; y++) {
    for (int x = 0; x < img4.width; x++) { 
      int jan = int(0);
      int pos = (y)*img4.width + (x); 
      ArrayList<Integer> valores = new ArrayList<>();
      
      
      // janela tamanho 1
      for(int i = jan*(-1); i <= jan; i++) {
        for (int j = jan*(-1); j <= jan; j++) {
          int ny = y+i;
          int nx = x+j;
          if(ny >= 0 && ny < img4.height &&
             nx >= 0 && nx < img4.width) {
              int pos_aux = ny * img4.width + nx;
              valores.add((int)(red(img4.pixels[pos_aux])));
             }
        }
     }
     
     // Calculo da Mediana
     Collections.sort(valores);
     aux2.pixels[pos] = color(valores.get(valores.size()/2));
    }
  }
  //Fim - Mediana
  
  //Brilho
  PImage img5 = loadImage("C:\\Users\\Thiago\\Desktop\\Faculdade\\7 Semestre\\Computação Grafica e Processamento de Imagens\\Projeto\\Filtros\\Preenchimento\\FlorBinaria_MioloPintado.jpg");
  PImage img9 = loadImage("C:\\Users\\Thiago\\Desktop\\Faculdade\\7 Semestre\\Computação Grafica e Processamento de Imagens\\Projeto\\Ground Truth\\5887.png");
  PImage aux3 = createImage(img5.width, img5.height, RGB);
  PImage aux9 = createImage(img9.width, img9.height, RGB);

  for (int y = 0; y < img5.height; y++) {
    for (int x = 0; x < img5.width; x++) {
      int pos = y * img5.width + x;
      float media = ((red(img5.pixels[pos]) + green(img5.pixels[pos]) + blue(img5.pixels[pos]))/3);
      aux3.pixels[pos] = color(media);
    }
  }
  for (int y = 0; y < img5.height; y++) {
    for (int x = 0; x < img5.width; x++) {
      int pos = y * img5.width + x;
      float valor = red(img5.pixels[pos])*5;
      if(valor > 255) valor = 255;
      else if (valor < 0) valor = 0;
      aux3.pixels[pos] = color(valor);
    }
  }
  
  for (int y = 0; y < img9.height; y++) {
    for (int x = 0; x < img9.width; x++) {
      int pos = y * img9.width + x;
      aux9.pixels[pos] = img9.pixels[pos];
    }
  }
  image(aux3, 0, 0);
  save("FlorBinariaNormal_Brilho.png");
  
  image(aux9, 0, 0);
  save("FlorBinariaOriginal.png");
  //Fim - Brilho
  
  //Comparacao
  int cont1 = 0;
  int cont2 = 0;
  int cont3 = 0;
  PImage img6 = loadImage("FlorBinariaOriginal.png");
  PImage img7 = loadImage("FlorBinariaNormal_Brilho.png");
  PImage aux4 = createImage(img6.width, img6.height, RGB);
  PImage aux5 = createImage(img7.width, img7.height, RGB);
  PImage aux6 = createImage(width, height, RGB);
  PImage aux7 = createImage(width, height, RGB);
  PImage aux8 = createImage(width,height, RGB);

  for(int y1 = 0;y1 < img6.height; y1++){
    for(int x1 = 0; x1 < img6.width; x1++){
      int pos1 = y1*img6.width + x1;
      aux4.pixels[pos1] = img6.pixels[pos1];
  }
}
  for(int y2 = 0;y2 < img7.height; y2++){
    for(int x2 = 0; x2 < img7.width; x2++){
      int pos2 = y2*img7.width + x2;
      aux5.pixels[pos2] = img7.pixels[pos2];
  }
}

  for(int y3 = 0;y3 < height; y3++){
    for(int x3 = 0; x3 < width; x3++){
      int pos3 = y3*width + x3;
      if(aux4.pixels[pos3] == aux5.pixels[pos3] || aux4.pixels[pos3] == color(255,255,255)){
        aux6.pixels[pos3] = aux7.pixels[pos3];
        aux6.pixels[pos3] = color(255,0,0);
}
}
}
  image(aux6,0,0);
  save("FlorBinaria_ComparadaIgual.png");

  for(int x4 = 0;x4 < width; x4++){
    for(int y4 = 0; y4 < height; y4++){
      int pos4 = y4*width + x4;
      if(aux4.pixels[pos4] != aux5.pixels[pos4] && aux4.pixels[pos4] != color(0,0,0)){
        aux7.pixels[pos4] = aux4.pixels[pos4];
        aux7.pixels[pos4] = color(0,255,0);
        cont2 = cont2 + 1;
}
}
}
  image(aux7,0,0);
  save("FlorBinaria_ComparadaDiferente.png");

  for(int x5 = 0;x5 < width; x5++){
    for(int y5 = 0; y5 < height; y5++){
      int pos5 = y5*width + x5;
      if(aux4.pixels[pos5] == aux5.pixels[pos5]){
        aux8.pixels[pos5] = aux4.pixels[pos5];
        //aux5.pixels[pos5] = color(0,255,0);
        cont3 = cont3 + 1;
}
}
}

  PImage img8 = loadImage("FlorBinaria_ComparadaIgual.png");
  for(int y6 = 0;y6 < height; y6++){
    for(int x6 = 0; x6 < width; x6++){
      int pos6 = y6*width + x6;
      if(img8.pixels[pos6] == color(0,0,0)){
        cont1 = cont1 + 1;
}
}
}

  image(aux8,0,0);
  save("FlorBinaria_ComparadaGeral.png");

  print("Quantidade de Pixels Falsos Positivos: ");
  print(cont1);
  print("\n");
  print("Quantidade de Pixels Falsos Negativos: ");
  print(cont2);
  print("\n");
  print("Quantidade de Pixels Iguais: ");
  print(cont3);
  String[] Valores = new String[0];


  Valores = append(Valores,"Quantidade de Pixels Falsos Positivos: " + str(cont1));
  Valores = append(Valores,"Quantidade de Pixels Falsos Negativos: " + str(cont2));
  Valores = append(Valores,"Quantidade de Pixels Errados: " + str(cont1 + cont2));
  Valores = append(Valores,"Quantidade de Pixels Iguais: " + str(cont3));

  saveStrings("Valores.txt",Valores);
  
  image(aux, 0, 0);
  save("Florbinaria.png");
  
  plotarLinhasOrientacao();
  save("FlorBinaria_Alinhada.jpg");
  
  image(img3,0,0);
  save("FlorBinaria_MioloPintado.jpg");
  
  image(aux2, 0, 0);
  save("FlorBinaria_Mediana.png");
  //Fim - Comparacao
  
  //Segmentacao
  PImage img10 = loadImage("FlorBinariaOriginal.png");
  PImage img11 = loadImage("FlorBinariaNormal_Brilho.png");
  PImage img12 = loadImage("5887.jpg");
  PImage aux10 = createImage(img10.width,img10.height, RGB);
  PImage aux11 = createImage(img11.width,img11.height, RGB);
  PImage aux12 = createImage(img12.width,img12.height, RGB);
  PImage aux13 = createImage(width,height,RGB);
  PImage aux14 = createImage(width,height,RGB);
  
  for(int y1 = 0;y1 < img10.height; y1++){
  for(int x1 = 0; x1 < img10.width; x1++){
    int pos1 = y1*img10.width + x1;
    aux10.pixels[pos1] = img10.pixels[pos1];
  }
}

for(int y2 = 0;y2 < img11.height; y2++){
  for(int x2 = 0; x2 < img11.width; x2++){
    int pos2 = y2*img11.width + x2;
    aux11.pixels[pos2] = img11.pixels[pos2];
  }
}

for(int y3 = 0;y3 < img12.height; y3++){
  for(int x3 = 0; x3 < img12.width; x3++){
    int pos3 = y3*img12.width + x3;
    aux12.pixels[pos3] = img12.pixels[pos3];
  }
}

for(int y4 = 0; y4 < height; y4++){
  for(int x4 = 0; x4 < width; x4++){
    int pos = (y4*width) + x4;
    if(aux10.pixels[pos] == color(255,255,255)){
      aux13.pixels[pos] = aux12.pixels[pos];
    }
  }
}

for(int y5 = 0; y5 < height; y5++){
  for(int x5 = 0; x5 < width; x5++){
    int pos = (y5*width) + x5;
    if(aux11.pixels[pos] == color(255,255,255)){
      aux14.pixels[pos] = aux12.pixels[pos];
    }
  }
}

image(aux13,0,0);
save("SegmentacaoOriginal.png");

image(aux14,0,0);
save("SegmentacaoAlgoritmo.png");
//Fim - Segmentacao
}

void plotarLinhasOrientacao(){
  strokeWeight(1);
  stroke(255,0,0);

  //Linhas Horizontais
  for (int i = 0; i <= 400; i+=20){
    line(0, i, 400, i);
    textSize(12);
    fill(255);
    text(i, 380, i);
  }

  //Linhas Verticais
  for (int i = 0; i <= 400; i+=20){
    line(i, 0, i, 300);
    textSize(12);
    fill(255);
    text(i, i, 10);
  }
 }
 
void preencher(int x, int y, PImage img) {
  int pos = y*img.width + x; 
  if(red(img.pixels[pos]) == 255) return;
  else {
      img.pixels[pos] = color(255,255,255);
      preencher(x,y-1,img);
      preencher(x,y+1,img);
      preencher(x-1,y,img);
      preencher(x+1,y,img);
  }
}
