import javax.swing.*;
import java.awt.*;
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


    public Village(ResultSet rs) throws SQLException {
        id = rs.getInt("id");
        idAccount = rs.getInt("id_account");
        health = rs.getInt("health");
        villageName = rs.getString("village_name");
        position_x = rs.getInt("position_x");
        position_y = rs.getInt("position_y");
        resources = rs.getInt("resources");
        villagelevel = rs.getInt("village_level");
        troopNumber = rs.getInt("troop_number");

        this.addActionListener(e -> {
            JOptionPane.showMessageDialog(null, this.position_x + " " + this.position_y + " res: " + this.resources);
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
    }

    public int getHealth() {
        return health;
    }

    public void setHealth(int health) {
        this.health = health;
    }

    public String getVillageName() {
        return villageName;
    }

    public void setVillageName(String villageName) {
        this.villageName = villageName;
    }

    public int getResources() {
        return resources;
    }

    public void setResources(int resources) {
        this.resources = resources;
    }

    public int getVillagelevel() {
        return villagelevel;
    }

    public void setVillagelevel(int villagelevel) {
        this.villagelevel = villagelevel;
    }

    public int getTroopNumber() {
        return troopNumber;
    }

    public void setTroopNumber(int troopNumber) {
        this.troopNumber = troopNumber;
    }
}
