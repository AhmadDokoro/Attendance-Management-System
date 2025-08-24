/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Session;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
/**
 *
 * @author PC
 */
public class getSessionsDao {
    public static List<Session> getSessionsByLecturer(int lecturerId) {
    List<Session> sessions = new ArrayList<>();
    String sql = "SELECT s.session_id, s.course_code, s.date, s.start_time, g.group_name " +
             "FROM Session s " +
             "JOIN GroupTable g ON s.group_id = g.group_id " +
             "WHERE s.lecturer_id = ? " +
             "ORDER BY s.date DESC, s.start_time DESC";

    try (Connection con = LoginDao.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, lecturerId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Session s = new Session();
            Session session = new Session();
            session.setSessionId(rs.getInt("session_id"));
            session.setCourseCode(rs.getString("course_code"));
            session.setDate(rs.getString("date"));
            session.setStartTime(rs.getString("start_time"));
            session.setGroupName(rs.getString("group_name")); // new field

            sessions.add(session);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return sessions;
}

}
