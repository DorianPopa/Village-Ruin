import javax.swing.*;

public class RegisterPage {
    private JTextField usernameField;
    public JPanel MainPanel;
    private JPasswordField passwordField;
    private JPasswordField retypePassword;
    private JButton registerButton;
    private JButton cancelButton;
    private JLabel usernameLabel;
    private JLabel passwordLabel;
    private JLabel retypePasswordLabel;

    public RegisterPage(JFrame frame) {
        usernameLabel.setText("Desired Username");
        passwordLabel.setText("Password");
        retypePasswordLabel.setText("Retype Password");

        registerButton.addActionListener(e -> {
            registerUser();
            frame.setContentPane(new LoginPage(frame).MainPanel);
            frame.pack();
        });
        cancelButton.addActionListener(e -> {
            frame.setContentPane(new LoginPage(frame).MainPanel);
            frame.pack();
        });
    }

    private boolean passwordsCheck(){
        return passwordField.getText().equals(retypePassword.getText());
    }

    private boolean usernameAlreadyUsed(){
        return DatabaseCalls.checkRegisterDuplicate(usernameField.getText());
    }

    private void registerUser(){
        boolean canRegister = true;
        if(usernameField.getText().equals("") || passwordLabel.getText().equals("")) canRegister = false;
        if(!passwordsCheck()){
            JOptionPane.showMessageDialog(null, new JLabel("Passwords do not match."));
            canRegister = false;
        }
        if(usernameAlreadyUsed()){
            JOptionPane.showMessageDialog(null, new JLabel("Username already taken"));
            canRegister = false;
        }
        if(canRegister){
            DatabaseCalls.registerUSER(usernameField.getText(), PasswordEncryption.hashPassword(passwordField.getText(), "SALTY").get());
            JOptionPane.showMessageDialog(null, new JLabel("Account registered. You can now login."));
        }
    }
}
