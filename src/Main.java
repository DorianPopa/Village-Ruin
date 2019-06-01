import javax.swing.*;
import javax.swing.plaf.ColorUIResource;
import java.awt.*;

public class Main {
    public static void main(String[] args) throws Exception {
        mainChestie();
    }
    public static void test(){

    }

    public static void mainChestie(){
        JFrame frame = new JFrame("VillageRuin");
        frame.setMinimumSize(new Dimension(800, 600));
        ToolTipManager.sharedInstance().setInitialDelay(0);
        UIManager.put("ToolTip.background", new ColorUIResource(255, 247, 200));
        UIManager.put("Button.foreground", SessionData.GLOBAL_FONT_COLOR);
        UIManager.put("Button.background", SessionData.BUTTON_COLOR);
        UIManager.put("Panel.background", SessionData.BACKGROUND_COLOR);
        UIManager.put("Label.foreground", SessionData.GLOBAL_FONT_COLOR);


        frame.setContentPane(new LoginPage(frame).MainPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
