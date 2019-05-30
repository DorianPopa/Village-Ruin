import javax.swing.*;

public class LoginPage {
    public JButton loginButton;
    public JPanel MainPanel;
    public JTextField usernameField;
    public JPasswordField passwordField;
    private JLabel usernameLabel;
    private JLabel passwordLabel;
    private JButton registerButton;


    public LoginPage(JFrame frame) {
        loginButton.addActionListener(e -> {
            if (passwordField.getText() != null && usernameField.getText() != null) {
                if (DatabaseCalls.accountDoesExist(usernameField.getText(), PasswordEncryption.hashPassword(passwordField.getText(), "SALTY").get())) {
                    JOptionPane.showMessageDialog(null, "Successfully logged in");
                    frame.setContentPane(new MapPage(frame).MainPanel);
                    frame.pack();
                } else
                    JOptionPane.showMessageDialog(null, "Account does not exist or something else went wrong");
            }
        });
        registerButton.addActionListener(e -> {
            frame.setContentPane(new RegisterPage(frame).MainPanel);
            frame.pack();
        });
    }

}
