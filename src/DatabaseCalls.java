import oracle.jdbc.OracleTypes;

import java.sql.*;


public class DatabaseCalls {

    public static void testConnection() throws SQLException {
        Connection con = Database.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from ACCOUNTS");
        while (rs.next()) {
            System.out.println(rs.getInt("ID") + " " + rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4) + " " + rs.getString(5));
        }
        rs.close();
        st.close();
        Database.closeConnection();
    }

    public static boolean checkRegisterDuplicate(String username){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN ?:= loginregisterfunctions.checkRegisterDuplicate( ?); END;");

            callableStatement.registerOutParameter(1, java.sql.Types.INTEGER);
            callableStatement.setString(2, username);
            callableStatement.execute();

            int rs = callableStatement.getInt(1);

            if(rs == 0){
                callableStatement.close();
                return false;
            }


        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
        }
        return true;
    }

    public static void registerUSER(String username, String password){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN loginregisterfunctions.registerUSER( ?, ?); END;");

            callableStatement.setString(1, username);
            callableStatement.setString(2, password);
            callableStatement.execute();
            callableStatement.close();
        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
        }
    }

    public static boolean accountDoesExist(String username, String password){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN ?:= loginregisterfunctions.accountDoesExist( ?, ?); END;");

            callableStatement.registerOutParameter(1, java.sql.Types.INTEGER);
            callableStatement.setString(2, username);
            callableStatement.setString(3, password);
            callableStatement.execute();

            int rs = callableStatement.getInt(1);
            if(rs == 0){
                callableStatement.close();
                return false;
            }

        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
        }
        return true;
    }

    public static void getVillagesByAccountId(int accountId){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN gameFunctions.getVillagesByAccountIdCursor( ?, ?); END;");

            callableStatement.registerOutParameter(2, OracleTypes.CURSOR);
            callableStatement.setInt(1, accountId);
            callableStatement.execute();

            ResultSet rs = (ResultSet)callableStatement.getObject(2);
            while(rs.next()){
                System.out.println(rs.getInt(1));
            }
        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
        }
    }

    public static ResultsetCallablestatement getAllVillages(int gameId){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN gameFunctions.getAllVillages( ?, ?); END;");

            callableStatement.registerOutParameter(2, OracleTypes.CURSOR);
            callableStatement.setInt(1, gameId);
            callableStatement.execute();

            ResultSet rs = (ResultSet)callableStatement.getObject(2);
            /*
                while(rs.next()){
                    System.out.println(rs.getInt("position_x") + " " + rs.getInt("position_y"));
                }
            */
            return new ResultsetCallablestatement(rs, callableStatement);
        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
            return null;
        }
    }

    public static int getAccountIdByName(String name){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN ?:= gameFunctions.getAccountIdByName( ?); END;");

            callableStatement.registerOutParameter(1, java.sql.Types.INTEGER);
            callableStatement.setString(2, name);
            callableStatement.execute();

            int result = callableStatement.getInt(1);
            callableStatement.close();
            return result;
        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
            return 0;
        }
    }

    public static void recruitTroopAtVillageById(int villageId){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN gameFunctions.recruitTroopAtVillageById( ?); END;");

            callableStatement.setInt(1, villageId);
            callableStatement.execute();
            callableStatement.close();
        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
        }
    }

    public static void increaseVillageLevelById(int villageId){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN gameFunctions.increaseVillageLevelById( ?); END;");

            callableStatement.setInt(1, villageId);
            callableStatement.execute();
            callableStatement.close();
        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
        }
    }

    public static void attackVillage(int originVillage, int targetVillage){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN gameFunctions.attackVillage( ?, ?); END;");

            callableStatement.setInt(1, originVillage);
            callableStatement.setInt(2, targetVillage);
            callableStatement.execute();
            callableStatement.close();
        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
        }
    }

    public static void closeCursor(ResultSet cursor){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN gameFunctions.closeCursor( ?); END;");

            callableStatement.setObject(1, cursor);
            callableStatement.execute();
            callableStatement.close();
        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
        }
    }

    public static ResultsetCallablestatement getAttacksByGameId(int gameId){
        try{
            Connection con = Database.getConnection();
            CallableStatement callableStatement = con.prepareCall("BEGIN statisticsFunctions.getAttacksByGameId( ?, ?); END;");

            callableStatement.registerOutParameter(2, OracleTypes.CURSOR);
            callableStatement.setInt(1, gameId);
            callableStatement.execute();

            ResultSet rs = (ResultSet)callableStatement.getObject(2);

            return new ResultsetCallablestatement(rs, callableStatement);
        }
        catch (SQLException e){
            System.out.println(e.getErrorCode());
            e.printStackTrace();
            return null;
        }
    }
}





//    public List<String> getDateAng(Connection con, int id_ang) throws SQLException {
//        try {
//            con = Database.getConnection();
//            List<String> a = new ArrayList<String>();
//            CallableStatement callablestatement = con.prepareCall("BEGIN ?:= pachetdate.getDateAng( ?); END;");
//
//            callablestatement.registerOutParameter(1, Types.ARRAY, "VARTIPDATE");
//            callablestatement.setInt(2, id_ang);
//            callablestatement.execute();
//            ResultSet rs = callablestatement.getArray(1).getResultSet();
//
//            while (rs.next()) {
//                String data = rs.getString(2);
//                a.add(data);
//                System.out.println(data);
//            }
//            return a;
//        }catch (Exception e){
//
//        }
//        return null;
//    }