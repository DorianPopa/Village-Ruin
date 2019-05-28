import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class LoginPage {
    public JButton loginButton;
    public JPanel MainPanel;
    public JTextField usernameField;
    public JPasswordField passwordField;
    private JLabel usernameLabel;
    private JLabel passwordLabel;
    private JButton registerButton;

    public LoginPage() {
        loginButton.addActionListener(e -> {
            if(DatabaseCalls.accountDoesExist(usernameField.getText(), passwordField.getText())){
                JOptionPane.showMessageDialog(null, "Successfully logged in");
            }
            else
                JOptionPane.showMessageDialog(null, "Account does not exist or something else went wrong");
        });
    }

}
