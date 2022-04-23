import java.util.Queue;
import java.util.LinkedList;
import java.awt.Point;

public class MyLib
{
    public MyLib ()
    {
    }

    public PImage EscalaCinza(PImage img, String modo)
    {
        PImage aux = createImage(img.width, img.height, RGB);
        switch (modo) 
        {
            case "red" :
                for (int y = 0; y < img.height; y++)
                {
                    for (int x = 0; x < img.width; x++)
                    {
                        int pos = y * img.width + x;
                        aux.pixels[pos] = color(red(img.pixels[pos]));
                    }
                }
            return aux;

            case "green" :
                for (int y = 0; y < img.height; y++)
                {
                    for (int x = 0; x < img.width; x++)
                    {
                        int pos = y * img.width + x;
                        aux.pixels[pos] = color(green(img.pixels[pos]));
                    }
                }
            return aux;

            case "blue" :
                for (int y = 0; y < img.height; y++)
                {
                    for (int x = 0; x < img.width; x++)
                    {
                        int pos = y * img.width + x;
                        aux.pixels[pos] = color(blue(img.pixels[pos]));
                    }
                }
            return aux;

            default :
                for (int y = 0; y < img.height; y++)
                {
                    for (int x = 0; x < img.width; x++)
                    {
                        int pos = y * img.width + x;
                        int media = int((red(img.pixels[pos]) + green(img.pixels[pos]) + blue(img.pixels[pos]))/3);
                        aux.pixels[pos] = color(media);
                    }
                }
            return aux; 
        }
    }

    public PImage Media4P(PImage img)
    {
        PImage img2 = createImage(img.width, img.height, RGB);
        for(int y = 0; y < img.height; y++)
        {
            for(int x = 0; x < img.width; x++)
            {
                int pos = y * img.width + x;
                int qtd = 0;
                float media = 0;
                int aux = 0;
                if(y != 0)
                {
                    aux = (y-1)* img.width + x;
                    media += red(img.pixels[aux]);
                    qtd ++;
                }
                if(y != (img.height - 1))
                {
                    aux = (y + 1)* img.width + x;
                    media += red(img.pixels[aux]);
                    qtd ++;
                }
                if(x != 0)
                {
                    aux = y* img.width + (x - 1);
                    media += red(img.pixels[aux]);
                    qtd ++;
                }
                if(x != (img.width-1))
                {
                    aux = y * img.width + (x + 1);
                    media += red(img.pixels[aux]);
                    qtd ++;
                }
                media += red(img.pixels[aux]);
                qtd ++;
                img2.pixels[pos] = color((media/qtd));
            }
        }
        return img2;
    }

    public void Preencher(PImage img, int x , int y, int cor , int cor2)
    {
        Queue<Point> q = new LinkedList<Point>();
        Point n;
        int pos;
        q.add(new Point(x, y));
        while(q.size() > 0)
        {
            n = q.remove();
            pos = n.y*img.width + n.x;
            if(red(img.pixels[pos]) == cor)
            {
                img.pixels[pos] = color(cor2);
                q.add(new Point(n.x, n.y+1));
                q.add(new Point(n.x, n.y-1));
                q.add(new Point(n.x+1, n.y));
                q.add(new Point(n.x-1, n.y));
            }
        }
    }
    
    void Grid(PImage img)
    {
        strokeWeight(1);
        stroke(0);
        for (int i = 0; i <= img.height ; i+=10)
        {
            line(0, i, 600, i);
            textSize(10);
            fill(255,0,0);
            text(i, 400, i+10);
        }
        for (int i = 0; i <= img.width; i+=10)
        {
            line(i, 0, i, 600);
            textSize(6);
            fill(255,0,0);
            text(i, i+10, 450);
         }
    }

    public PImage Brilho(PImage img, float brilho)
    {
        PImage aux = createImage(img.width, img.height, RGB);
        for (int y = 0; y < img.height; y++)
        {
            for (int x = 0; x < img.width; x++)
            {
                int pos = y * img.width + x;
                float valor = red(img.pixels[pos])*brilho;
                if(valor > 255)
                {
                    valor = 255;
                }
                else if(valor < 0)
                {
                    valor = 0;
                }
                aux.pixels[pos] = color(valor);
            }
        }
        return aux;
    }

    private float gauss(int x, int y , float param)
    {
        return ((1/(2*PI*pow(param,2)))*exp(-(pow(x,2)+pow(y,2))/(2*pow(param,2))));
    }

    public PImage Gaussiano(PImage img, PImage aux, float paramGauss)
    {
        PImage aux2 = createImage(img.width, img.height, RGB);
        float[][] gx = {{gauss(-1, -1, paramGauss), gauss(0, -1, paramGauss), gauss(1, -1, paramGauss)},
                        {gauss(-1, 0, paramGauss), gauss(0, 0, paramGauss), gauss(1, 0, paramGauss)},
                        {gauss(-1, 1, paramGauss), gauss(0, 1, paramGauss), gauss(1, 1, paramGauss)}};
        float[][] gy = {{gauss(-1, -1, paramGauss), gauss(0, -1, paramGauss), gauss(1, -1, paramGauss)},
                        {gauss(-1, 0, paramGauss), gauss(0, 0, paramGauss), gauss(1, 0, paramGauss)},
                        {gauss(-1, 1, paramGauss), gauss(0, 1, paramGauss), gauss(1, 1, paramGauss)}};
        int janela = 1;
        for (int y = 0; y < img.height; y++)
        {
            for (int x = 0; x < img.width; x++)
            {
                int pos = (y)*img.width + (x);
                float mediaOx = 0, mediaOy = 0;
                for(int i = janela*(-1); i <= janela; i++)
                {
                    for (int j = janela*(-1); j <= janela; j++) {
                        int disy = y+i;
                        int disx = x+j;
                        if(disy >= 0 && disy < img.height && disx >= 0 && disx < img.width)
                        {
                            int pos_aux = disy * img.width + disx;
                            float Ox = red(aux.pixels[pos_aux]) * gx[i+1][j+1];
                            float Oy = red(aux.pixels[pos_aux]) * gy[i+1][j+1];
                            mediaOx += Ox;
                            mediaOy += Oy;
                        }
                    }
                }
                float mediaFinal = sqrt(mediaOx * mediaOx + mediaOy*mediaOy);
                aux2.pixels[pos] = color(mediaFinal);
            }
        }
        return aux2;
    }

    public PImage Sobel(PImage img, PImage aux)
    {
      img.loadPixels();
        PImage aux2 = createImage(img.width, img.height, RGB);
        int janela = 1;
        int[][] gx ={{-1, -2, -1},
                     {0, 0, 0},
                     {1, 2, 1}};
        int[][] gy ={{-1, 0, 1},
                     {-2, 0, 2},
                     {-1, 0, 1}};
        for (int y = 0; y < img.height; y++)
        {
            for (int x = 0; x < img.width; x++)
            {
                int pos = (y)*img.width + (x);
                float mediaOx = 0, mediaOy = 0;
                for(int i = janela*(-1); i <= janela; i++)
                {
                    for (int j = janela*(-1); j <= janela; j++)
                    {
                        int disy = y+i;
                        int disx = x+j;
                        if(disy >= 0 && disy < img.height && disx >= 0 && disx < img.width)
                        {
                            int pos_aux = disy * img.width + disx;
                            float Ox = red(aux.pixels[pos_aux]) * gx[i+1][j+1];
                            float Oy = red(aux.pixels[pos_aux]) * gy[i+1][j+1];
                            mediaOx += Ox;
                            mediaOy += Oy;
                        }
                    }
                }
                float mediaFinal = sqrt(mediaOx*mediaOx + mediaOy*mediaOy);
                if(mediaFinal > 255)
                {
                    mediaFinal = 255;
                }
                if(mediaFinal < 0)
                {
                    mediaFinal = 0;
                }
                aux2.pixels[pos] = color(mediaFinal);
            }
        }
        return aux2;
    }

    public void Limiarizacao(PImage img, int corte)
    {
        for (int y = 0; y < img.height; y++)
        {
            for (int x = 0; x < img.width; x++)
            { 
                int pos = (y)*img.width + (x);
                if( red(img.pixels[pos]) > corte)
                {
                    img.pixels[pos] = color(255);
                }
                else
                {
                    img.pixels[pos] = color(0);
                }
            }
        }
    }

    public PImage Comparacao(PImage original, PImage obtida)
    {
        int certo = 0;
        int falso_positivo = 0;
        int falso_negativo = 0;
        PImage aux = createImage(original.width, original.height, RGB);
        for(int y = 0; y < original.height; y++)
        {
            for(int x = 0; x < original.width; x++)
            {
                int pos = y * original.width + x;
                if(red(original.pixels[pos]) == red(obtida.pixels[pos]))
                {
                    certo ++;
                    aux.pixels[pos] = color(0, 255, 0);
                }
                else if((red(original.pixels[pos]) == 0) && (red(obtida.pixels[pos]) == 255))
                {
                    falso_positivo ++;
                    aux.pixels[pos] = color(255, 0, 0);
                }
                else if((red(original.pixels[pos]) == 255) && (red(obtida.pixels[pos]) == 0))
                {
                    falso_negativo ++;
                    aux.pixels[pos] = color(0, 0, 255);
                }
            }
        }
        print("Certos : ");
        println(certo + " = " + float(certo)/(original.width * original.height) + "%");
        print("Falso positivo : ");
        println(falso_positivo + " = " + float(falso_positivo)/(original.width * original.height) + "%");
        print("Falso negativo : ");
        println(falso_negativo + " = " + float(falso_negativo)/(original.width * original.height) + "%");
        return aux;
    }

    public PImage Recorte(PImage img, PImage obtida)
    {
        PImage aux = createImage(img.width, img.height, RGB);
        aux = img;
        for(int y = 0; y < img.height; y++)
        {
            for(int x = 0; x < img.width; x++)
            {
                int pos = y * img.width + x;
                if(red(obtida.pixels[pos]) == 0)
                {
                    aux.pixels[pos] = color(0);
                }
            }
        }
        return aux;
    }
}
