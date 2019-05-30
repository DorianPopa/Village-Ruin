import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class MapPage {
    private JLabel titleLabel = new JLabel("Map", JLabel.CENTER);
    public JPanel MainPanel;

    private JPanel mapPanel = new JPanel();
    private int mapSize = 25;

    private ArrayList buttonList = new ArrayList<JButton>();
    private File buttonImage;
    private BufferedImage img;

    public MapPage(JFrame frame){
        BorderLayout mainLayout = new BorderLayout();
        MainPanel.setLayout(mainLayout);
        MainPanel.add(titleLabel, BorderLayout.NORTH);


        GridLayout mapLayout = new GridLayout(mapSize,mapSize);
        mapPanel.setLayout(mapLayout);
        initImages();
        setButtons();

        MainPanel.add(mapPanel, BorderLayout.SOUTH);
    }

    private void initImages(){
        try {
            buttonImage = new File("resources/village.png");
            img = ImageIO.read(buttonImage);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void setButtons(){
        for(int i = 0;i < mapSize;i++)
            for(int j = 0;j < mapSize; j++)
                mapPanel.add(createButton());
    }

    private JButton createButton(){
        JButton button = new JButton();
        button.setMargin(new Insets(0, 0, 0, 0));
        button.setBorder(null);
        button.setIcon(new ImageIcon(img));
        button.setBackground(Color.MAGENTA);
        buttonList.add(button);
        return button;
    }

}
