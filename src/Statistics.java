import org.tc33.jheatchart.HeatChart;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

public class Statistics {
    private double[][] heatMap = new double[21][21];

    public void generateHeatMap(int gameId){
        ResultsetCallablestatement rs = DatabaseCalls.getAttacksByGameId(gameId);
        int i = 0;
        while(true){
            try {
                if (!rs.rs.next()) break;
                heatMap[rs.rs.getInt("position_x")][rs.rs.getInt("position_y")] ++;

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public String renderHeatMap(int gameId){
        HeatChart renderedImage = new HeatChart(heatMap);
        renderedImage.setTitle("Heatmap for game no. " + gameId);
        renderedImage.setXAxisLabel("X Axis");
        renderedImage.setYAxisLabel("Y Axis");

        try {
            renderedImage.saveToFile(new File("Heatmap-game" + gameId + ".png"));
            return "Heatmap-game" + gameId + ".png";
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
