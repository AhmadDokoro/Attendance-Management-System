/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Attendance;
import java.sql.*;

public class AttendanceDAO {

    // 1. Check if student exists by matric and password
    public static int getStudentId(String matric, String password) {
        int studentId = -1;
        try (Connection con = LoginDao.getConnection()) {
            String sql = "SELECT student_id FROM Student WHERE matric_number = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, matric);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                studentId = rs.getInt("student_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return studentId;
    }

    // 2. Check if student already marked attendance for session
    public static boolean hasMarkedAttendance(int studentId, int sessionId) {
        boolean exists = false;
        try (Connection con = LoginDao.getConnection()) {
            String sql = "SELECT * FROM Attendance WHERE student_id = ? AND session_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, sessionId);
            ResultSet rs = ps.executeQuery();
            exists = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    // 3. Save attendance
    public static boolean saveAttendance(Attendance attendance) {
        boolean success = false;
        try (Connection con = LoginDao.getConnection()) {
            String sql = "INSERT INTO Attendance (student_id, session_id, ip_address) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, attendance.getStudentId());
            ps.setInt(2, attendance.getSessionId());
            ps.setString(3, attendance.getIpAddress());
 

            success = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
}

