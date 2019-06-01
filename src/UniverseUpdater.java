import javax.swing.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;

public class UniverseUpdater {

    public UniverseUpdater(ArrayList<Village> villageList) {
        TimerTask timerTask = new TimerTask() {
            @Override
            public void run() {
                int i = 0;
                ResultsetCallablestatement chestie = DatabaseCalls.getAllVillages(1);
                ResultSet rs = chestie.rs;
                CallableStatement cs = chestie.cs;

                while(true){
                    //System.out.println(i);
                    try {
                        if(rs == null) { JOptionPane.showMessageDialog(null, new JLabel("Kicked for too many actions. The game will close.")); break; }
                        if (!rs.next()) break;
                        Village v = new Village(rs);
                        if(villageList.get(i).getHealth() != v.getHealth())
                            villageList.get(i).setHealth(v.getHealth());
                        if(villageList.get(i).getIdAccount() != v.getIdAccount())
                            villageList.get(i).setIdAccount(v.getIdAccount());
                        if(villageList.get(i).getVillageName() != v.getVillageName())
                            villageList.get(i).setVillageName(v.getVillageName());
                        if(villageList.get(i).getResources() != v.getResources())
                            villageList.get(i).setResources(v.getResources());
                        if(villageList.get(i).getVillagelevel() != v.getVillagelevel())
                            villageList.get(i).setVillagelevel(v.getVillagelevel());
                        if(villageList.get(i).getTroopNumber() != v.getTroopNumber())
                            villageList.get(i).setTroopNumber(v.getTroopNumber());
                        i++;
                    } catch (SQLException e) {
                        System.out.println(e.getErrorCode());
                        e.printStackTrace();
                    }
                }
                try {
                    if(rs != null)
                        rs.close();
                    if(cs != null)
                        cs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        };
        Timer timer = new Timer("Updater");//create a new Timer
        timer.scheduleAtFixedRate(timerTask, 30, 500);//this line starts the timer at the same time its executed
    }
}