import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class LoginPage {
    public JButton loginButton;
    public JPanel MainPanel;
    public JTextField usernameField;
    public JPasswordField passwordField;
    private JLabel usernameLabel;
    private JLabel passwordLabel;
    private JButton registerButton;
    private JLabel Logo;
    private JTextField gameNumber;
    private JButton seeStatsButton;

    private File unprocessedImage;
    private BufferedImage background;


    public LoginPage(JFrame frame) {

        loginButton.addActionListener(e -> {
            if (passwordField.getText() != null && usernameField.getText() != null) {
                if (DatabaseCalls.accountDoesExist(usernameField.getText(), PasswordEncryption.hashPassword(passwordField.getText(), "SALTY").get())) {
                    SessionData.accountId = DatabaseCalls.getAccountIdByName(usernameField.getText());
                    SessionData.gameId = DatabaseCalls.getCurrentRunningGameId(SessionData.accountId);
                    JOptionPane.showMessageDialog(null, new JLabel("Successfully logged in"));
                    frame.setContentPane(new MapPage(frame).MainPanel);
                    frame.pack();
                } else
                    JOptionPane.showMessageDialog(null, new JLabel("Account does not exist or something else went wrong"));
            }
        });

        registerButton.addActionListener(e -> {
            frame.setContentPane(new RegisterPage(frame).MainPanel);
            frame.pack();
        });

        try {
            unprocessedImage = new File("resources/VillageRuin.png");
            background = ImageIO.read(unprocessedImage);
        } catch (IOException e) {
            e.printStackTrace();
        }

        Logo.setIcon(new ImageIcon(background));

        seeStatsButton.addActionListener(e -> {
            Statistics statistics = new Statistics();
            statistics.generateHeatMap(Integer.parseInt(gameNumber.getText()));
            File img = new File(statistics.renderHeatMap(Integer.parseInt(gameNumber.getText())));
            try {
                BufferedImage endImage = ImageIO.read(img);
                JDialog dialog = new JDialog();
                JLabel imageLabel = new JLabel(new ImageIcon(endImage));

                JOptionPane.showMessageDialog(null, imageLabel);
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        });
    }
}
