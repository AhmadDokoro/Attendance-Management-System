/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Group;
import Model.Session;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SessionDao {

    public static int saveSession(Session session) {
        int sessionId = -1;

        try (Connection con = LoginDao.getConnection()) {
            String sql = "INSERT INTO Session (lecturer_id, group_id, course_code, program_type, location, start_time, end_time, duration, date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, session.getLecturerId());
            ps.setInt(2, session.getGroupId());
            ps.setString(3, session.getCourseCode());
            ps.setString(4, session.getProgramType());
            ps.setString(5, session.getLocation());
            ps.setString(6, session.getStartTime());
            ps.setString(7, session.getEndTime());
            ps.setInt(8, session.getDuration());
            ps.setString(9, session.getDate());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                sessionId = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return sessionId;
    }
    
    public static Session getSessionById(int sessionId) {
    Session session = null;

    try (Connection con = LoginDao.getConnection()) {
        String sql = "SELECT s.*, g.group_name " +
                     "FROM Session s " +
                     "JOIN GroupTable g ON s.group_id = g.group_id " +
                     "WHERE s.session_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, sessionId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            session = new Session();
            session.setSessionId(rs.getInt("session_id"));
            session.setLecturerId(rs.getInt("lecturer_id"));
            session.setGroupId(rs.getInt("group_id"));
            session.setCourseCode(rs.getString("course_code"));
            session.setProgramType(rs.getString("program_type"));
            session.setLocation(rs.getString("location"));
            session.setStartTime(rs.getString("start_time"));
            session.setEndTime(rs.getString("end_time"));
            session.setDuration(rs.getInt("duration"));
            session.setDate(rs.getString("date"));
            session.setGroupName(rs.getString("group_name")); 
        }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return session;
    }
    
    
    public static Session getSessionByIdForUpdateAttendance(int sessionId) {
    Session session = null;
    try (Connection con = LoginDao.getConnection()) {
        String sql = "SELECT * FROM Session WHERE session_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, sessionId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            session = new Session();
            session.setSessionId(rs.getInt("session_id"));
            session.setGroupId(rs.getInt("group_id"));
            session.setCourseCode(rs.getString("course_code"));
            session.setLocation(rs.getString("location"));
            session.setProgramType(rs.getString("program_type"));
            session.setDuration(rs.getInt("duration"));
            session.setStartTime(rs.getString("start_time"));
            session.setEndTime(rs.getString("end_time"));
            session.setDate(rs.getString("date"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return session;
}

    
    
    
    
    
    
    
    
    
    
    
    public static List<Group> getCourseGroupPairsByLecturer(int lecturerId) {
        List<Group> result = new ArrayList<>();

        try (Connection con = LoginDao.getConnection()) {
            String sql = "SELECT g.group_id, g.group_name, g.course_code, c.course_name " +
                         "FROM GroupTable g " +
                         "JOIN CourseGroup cg ON g.group_id = cg.group_id " +
                         "JOIN Course c ON g.course_code = c.course_code " +
                         "WHERE cg.lecturer_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, lecturerId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Group g = new Group();
                g.setGroupId(rs.getInt("group_id"));
                g.setGroupName(rs.getString("group_name"));
                g.setCourseCode(rs.getString("course_code"));
                g.setCourseName(rs.getString("course_name")); // Add this in your model if needed
                result.add(g);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    
    
    
    public static List<Group> getGroupsByLecturerAndCourse(int lecturerId) {
        List<Group> groupList = new ArrayList<>();

        try (Connection con = LoginDao.getConnection()) {
            String sql = "SELECT g.group_id, g.group_name FROM GroupTable g " +
                         "JOIN CourseGroup cg ON g.group_id = cg.group_id " +
                         "WHERE cg.lecturer_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, lecturerId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Group group = new Group();
                group.setGroupId(rs.getInt("group_id"));
                group.setGroupName(rs.getString("group_name"));
                groupList.add(group);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return groupList;
    }


}

