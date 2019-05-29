import javax.swing.*;

public class RegisterPage {
    private JTextField usernameField;
    public JPanel MainPanel;
    private JPasswordField passwordField;
    private JPasswordField retypePassword;
    private JButton registerButton;
    private JButton cancelButton;

    public RegisterPage(JFrame frame) {
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
        if(!passwordsCheck()){
            JOptionPane.showMessageDialog(null, "Passwords do not match.");
            canRegister = false;
        }
        if(usernameAlreadyUsed()){
            JOptionPane.showMessageDialog(null, "Username already taken");
            canRegister = false;
        }
        if(canRegister){
            DatabaseCalls.registerUSER(usernameField.getText(), passwordField.getText());
            JOptionPane.showMessageDialog(null, "Account registered. You can now login.");
        }
    }
}
