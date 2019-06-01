import javax.swing.*;
import java.awt.*;


public class SidePanel {
    public  JPanel sidePanel;
    private JButton recruitButton;
    private JButton levelUpButton;
    public JButton ataccButton;
    private JLabel villageName;
    private JLabel villageLevel;
    private JLabel villageResources;
    private JLabel villageTroops;
    private JLabel villageHealth;
    private JPanel theActualPanel;


    public SidePanel(){
        sidePanel.setPreferredSize(new Dimension(200, -1));

        recruitButton.setVisible(false);
        levelUpButton.setVisible(false);
        ataccButton.setVisible(false);


        recruitButton.addActionListener(e -> {
            DatabaseCalls.recruitTroopAtVillageById(MapPage.selectedVillage.getId());
            MapPage.isAttacking = false;
        });
        levelUpButton.addActionListener(e -> {
            DatabaseCalls.increaseVillageLevelById(MapPage.selectedVillage.getId());
            MapPage.isAttacking = false;
        });
        ataccButton.addActionListener(e -> {
            MapPage.isAttacking = !MapPage.isAttacking;
            if(MapPage.isAttacking)
                ataccButton.setBackground(SessionData.SELECTED_COLOR);
            else
                ataccButton.setBackground(SessionData.BUTTON_COLOR);

        });
    }

    public void setVillage(Village v){
        villageName.setText("Village Name: " + v.getVillageName());
        villageLevel.setText("Village Level: " + Integer.toString(v.getVillagelevel()));
        villageResources.setText("Village resources: " + Integer.toString(v.getResources()));
        villageTroops.setText("Village Troops: " + Integer.toString(v.getTroopNumber()));
        villageHealth.setText("Village Health: " + Integer.toString(v.getHealth()));

        if(!MapPage.isAttacking)
            ataccButton.setBackground(SessionData.BUTTON_COLOR);

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
