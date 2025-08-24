/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;


public class StudentDao {
    
    
    
    
    
    public static List<Student> getStudentsNotAttended(int sessionId, int groupId) {
    List<Student> students = new ArrayList<>();

    try (Connection con = LoginDao.getConnection()) {
        String sql = "SELECT s.student_id, s.name, s.matric_number " +
                     "FROM student s " +
                     "JOIN studentgroup sg ON s.student_id = sg.student_id " +
                     "WHERE sg.group_id = ? " +
                     "AND s.student_id NOT IN (" +
                     "    SELECT a.student_id FROM attendance a WHERE a.session_id = ?" +
                     ")";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, groupId);
        ps.setInt(2, sessionId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Student s = new Student();
            s.setId(rs.getInt("student_id"));
            s.setName(rs.getString("name"));
            s.setMatric(rs.getString("matric_number"));
            students.add(s);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return students;
}
    
    
    
    
    
     public static boolean saveManualAttendance(String[] studentIds, int sessionId) {
        boolean allSaved = true;

        try (Connection con = LoginDao.getConnection()) {
            String sql = "INSERT INTO Attendance (student_id, session_id, marked_by_lecturer) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            for (String id : studentIds) {
                ps.setInt(1, Integer.parseInt(id));
                ps.setInt(2, sessionId);
                ps.setBoolean(3, true);
                ps.addBatch();
            }

            int[] result = ps.executeBatch();
            for (int res : result) {
                if (res == PreparedStatement.EXECUTE_FAILED) {
                    allSaved = false;
                    break;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            allSaved = false;
        }

        return allSaved;
    }

}
