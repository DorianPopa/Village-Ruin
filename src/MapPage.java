import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MapPage {
    private JLabel titleLabel = new JLabel("Map", JLabel.CENTER);
    public JPanel MainPanel;

    private JPanel mapPanel = new JPanel();
    private int mapSize = 25;

    private ResultSet villagesCursor;
    private ArrayList villageList = new ArrayList<Village>();

    private File unprocessedImage;
    private BufferedImage villageSprite;
    private BufferedImage blankSprite;

    UniverseUpdater updater;

    public MapPage(JFrame frame){
        villagesCursor = DatabaseCalls.getAllVillages(1);

        BorderLayout mainLayout = new BorderLayout();
        MainPanel.setLayout(mainLayout);
        MainPanel.add(titleLabel, BorderLayout.NORTH);

        GridLayout mapLayout = new GridLayout(mapSize,mapSize);
        mapPanel.setLayout(mapLayout);
        initImages();

        try {
            createMap();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        MainPanel.add(mapPanel, BorderLayout.SOUTH);
        updater = new UniverseUpdater(villageList);
    }

    private void initImages(){
        try {
            unprocessedImage = new File("resources/village.png");
            villageSprite = ImageIO.read(unprocessedImage);

            unprocessedImage = new File("resources/grass.png");
            blankSprite = ImageIO.read(unprocessedImage);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void createMap() throws SQLException {
        int i = 0;
        int j = 0;
        while(villagesCursor.next()){
            int villageX = villagesCursor.getInt("position_x");
            int villageY = villagesCursor.getInt("position_y");
            while(villagesCursor.getInt("position_x") != i || villagesCursor.getInt("position_y") != j){
                mapPanel.add(createBlank());
                j++;
                if(j >= mapSize){
                    j = 0; i++;
                }
            }
            mapPanel.add(createVillage());
            j++;
            if(j >= mapSize){
                j = 0; i++;
            }
        }
        while(j < mapSize && i < mapSize){
            mapPanel.add(createBlank());
            j++;
            if(j >= mapSize){
                j = 0; i++;
            }
        }
    }

    private Village createVillage(){
        try {
            Village village = new Village(villagesCursor);
            village.setMargin(new Insets(0, 0, 0, 0));
            village.setBorder(null);
            village.setIcon(new ImageIcon(villageSprite));
            village.setBackground(Color.MAGENTA);
            villageList.add(village);
                return village;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private JButton createBlank(){
        JButton button = new JButton();
        button.setMargin(new Insets(0, 0, 0, 0));
        button.setBorder(null);
        button.setIcon(new ImageIcon(blankSprite));

        //villageList.add(button);

        return button;
    }

}
