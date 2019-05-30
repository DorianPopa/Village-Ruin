import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Village extends JButton {
    private int id;
    private int idAccount;
    private int health;
    private String villageName;
    private int position_x;
    private int position_y;
    private int resources;
    private int villagelevel;
    private int troopNumber;
    private String toolTipText;

    private static File unprocessedImage = new File("resources/village.png");
    private static BufferedImage villageWithOwner;


    public Village(ResultSet rs) throws SQLException {
        loadImages();

        id = rs.getInt("id");
        idAccount = rs.getInt("id_account");
        health = rs.getInt("health");
        villageName = rs.getString("village_name");
        position_x = rs.getInt("position_x");
        position_y = rs.getInt("position_y");
        resources = rs.getInt("resources");
        villagelevel = rs.getInt("village_level");
        troopNumber = rs.getInt("troop_number");

        updateToolTipText();

        this.addActionListener(e -> {
            JOptionPane.showMessageDialog(null, this.position_x + " " + this.position_y + " res: " + this.resources + "ID: " + this.idAccount);
        });
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdAccount() {
        return idAccount;
    }

    public void setIdAccount(int idAccount) {
        this.idAccount = idAccount;
        if(idAccount == SessionData.accountId)
            this.setBackground(Color.BLUE);
        else
            this.setBackground(Color.MAGENTA);

        if(this.idAccount != 0){
            this.setIcon(new ImageIcon(villageWithOwner));
        }
    }

    public int getHealth() {
        return health;
    }

    public void setHealth(int health) {
        this.health = health;
        updateToolTipText();
    }

    public String getVillageName() {
        return villageName;
    }

    public void setVillageName(String villageName) {
        this.villageName = villageName;
        updateToolTipText();
    }

    public int getResources() {
        return resources;
    }

    public void setResources(int resources) {
        this.resources = resources;
        updateToolTipText();
    }

    public int getVillagelevel() {
        return villagelevel;
    }

    public void setVillagelevel(int villagelevel) {
        this.villagelevel = villagelevel;
        updateToolTipText();
    }

    public int getTroopNumber() {
        return troopNumber;
    }

    public void setTroopNumber(int troopNumber) {
        this.troopNumber = troopNumber;
        updateToolTipText();
    }

    private void loadImages(){
        try {
            villageWithOwner = ImageIO.read(unprocessedImage);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void updateToolTipText(){
        toolTipText = "<html>";
        toolTipText += villageName + " | " + "LVL: " + villagelevel + "<br>";
        toolTipText += "Health: " + health + "<br>";
        toolTipText += "Resources: " + resources + "<br>";
        toolTipText += "Troops: " + troopNumber + "<br>";
        toolTipText += "</html>";
        this.setToolTipText(toolTipText);
    }
}
