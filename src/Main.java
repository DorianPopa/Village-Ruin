import javax.swing.*;

public class Main {
    public static void main(String[] args) throws Exception {
        JFrame frame = new JFrame("VillageRuin");
        frame.setContentPane(new LoginPage(frame).MainPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);

    }
}
