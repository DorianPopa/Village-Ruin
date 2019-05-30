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
                ResultSet rs = DatabaseCalls.getAllVillages(1);
                while(true){
                    System.out.println(i);
                    try {
                        if (!rs.next()) break;
                        Village v = new Village(rs);
                        villageList.get(i).setHealth(v.getHealth());
                        villageList.get(i).setIdAccount(v.getIdAccount());
                        villageList.get(i).setVillageName(v.getVillageName());
                        villageList.get(i).setResources(v.getResources());
                        villageList.get(i).setVillagelevel(v.getVillagelevel());
                        villageList.get(i).setTroopNumber(v.getTroopNumber());
                        i++;
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                }
            }
        };
        Timer timer = new Timer("Updater");//create a new Timer
        timer.scheduleAtFixedRate(timerTask, 30, 2000);//this line starts the timer at the same time its executed
    }
}