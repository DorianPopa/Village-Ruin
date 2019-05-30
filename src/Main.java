import javax.swing.*;
import java.awt.*;

public class Main {
    public static void main(String[] args) throws Exception {
        //test();
        mainChestie();
    }
    public static void test(){
        //DatabaseCalls.getVillagesByAccountId(75);
        System.out.println(PasswordEncryption.hashPassword("LuL", "salty").get());
    }

    public static void mainChestie(){
        JFrame frame = new JFrame("VillageRuin");
        frame.setMinimumSize(new Dimension(800, 600));
        frame.setContentPane(new LoginPage(frame).MainPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
