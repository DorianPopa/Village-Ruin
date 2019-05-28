import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Main {
    public static void main(String [] args) throws Exception {
        testConnection();
    }

    public static void testConnection() throws SQLException {
        Connection con = Database.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select id, nume from studenti");
        while(rs.next()){
            System.out.println(rs.getInt("ID") + " " + rs.getString("NUME"));
        }
        rs.close();
        st.close();
        Database.closeConnection();
    }
}
