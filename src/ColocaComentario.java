import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Scanner;

public class ColocaComentario {
    public static void main(String[] args) {
        escreveArq(leArq());
    }

    public static ArrayList<String> leArq() {
        ArrayList<String> linhas = new ArrayList<>();
        Path path = Paths.get("codigo.txt");
        try (BufferedReader br = Files.newBufferedReader(path, Charset.defaultCharset())) {
            String linha = null;
            String linhaCod;
            ArrayList<String> paradas = new ArrayList<>();
            while ((linha = br.readLine()) != null) {
                // separador: ;
                Scanner sc = new Scanner(linha).useDelimiter("\n");
                if(!linha.equals("") ) {
                    linhaCod = sc.next();
                    linhas.add("# "+linhaCod);
                    System.out.println(linhaCod);
                }else{
                    linhas.add("#");
                }
            }
        }catch (Exception e){
            System.out.println("Erro ao ler: " + e.getMessage());
        }
        return linhas;
    }

    public static void escreveArq(ArrayList<String> linhas) {
        Path path = Paths.get("codigoComentado.txt");
        try (PrintWriter info = new PrintWriter(Files.newBufferedWriter(path, Charset.defaultCharset()))) {
            for (String l : linhas) {
                info.format("%s\n", l);
            }
        } catch (IOException e) {
            System.out.println("Erro ao gravar arquivo: " + e.getMessage());
            ;
        }
    }
}


