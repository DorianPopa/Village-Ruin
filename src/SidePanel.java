import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.DataBuffer;

public class SidePanel {
    public  JPanel sidePanel;
    private JButton recruitButton;
    private JButton levelUpButton;
    private JButton ataccButton;
    private JLabel villageName;
    private JLabel villageLevel;
    private JLabel villageResources;
    private JLabel villageTroops;


    public SidePanel(){
        sidePanel.setPreferredSize(new Dimension(200, -1));

        recruitButton.setVisible(false);
        levelUpButton.setVisible(false);
        ataccButton.setVisible(false);

        recruitButton.addActionListener(e -> {
            DatabaseCalls.recruitTroopAtVillageById(MapPage.selectedVillage.getId());
        });
        levelUpButton.addActionListener(e -> {
            DatabaseCalls.increaseVillageLevelById(MapPage.selectedVillage.getId());
        });
        ataccButton.addActionListener(e -> {

        });
    }

    public void setVillage(Village v){
        villageName.setText("Village Name: " + v.getVillageName());
        villageLevel.setText("Village Level: " + Integer.toString(v.getVillagelevel()));
        villageResources.setText("Village resources: " + Integer.toString(v.getResources()));
        villageTroops.setText("Village Troops: " + Integer.toString(v.getTroopNumber()));

        if(SessionData.accountId == v.getIdAccount()){
            recruitButton.setVisible(true);
            levelUpButton.setVisible(true);
            ataccButton.setVisible(true);
        }
        else{
            recruitButton.setVisible(false);
            levelUpButton.setVisible(false);
            ataccButton.setVisible(false);
        }
    }
}
