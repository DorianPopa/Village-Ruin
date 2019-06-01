import java.sql.CallableStatement;
import java.sql.ResultSet;

public class ResultsetCallablestatement {
    public ResultSet rs;
    public CallableStatement cs;

    public ResultsetCallablestatement(ResultSet rss, CallableStatement css){
        this.rs = rss;
        this.cs = css;
    }
}
