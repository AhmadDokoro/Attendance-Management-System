package DAO;

import Model.LeaveRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.*;
import DAO.LoginDao;
import java.util.ArrayList;
import java.util.List;

public class LeaveRequestDao {

    public static boolean submitLeaveRequest(LeaveRequest request) {
        String sql = "INSERT INTO leaverequest (student_id, course_code, group_id, lecturer_id, title, description, proof_file_path, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = LoginDao.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, request.getStudentId());
            ps.setString(2, request.getCourseCode());
            ps.setInt(3, request.getGroupId());
            ps.setInt(4, request.getLecturerId());
            ps.setString(5, request.getTitle());
            ps.setString(6, request.getDescription());
            ps.setString(7, request.getProofFilePath());
            ps.setString(8, "Pending");

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    
    public static List<LeaveRequest> getRequestsByStudentId(int studentId) {
        List<LeaveRequest> list = new ArrayList<>();
        String query = "SELECT * FROM leaverequest WHERE student_id = ?";

        try (Connection con = LoginDao.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LeaveRequest req = new LeaveRequest();
                req.setRequestId(rs.getInt("request_id"));
                req.setTitle(rs.getString("title"));
                req.setCourseCode(rs.getString("course_code"));
                req.setStatus(rs.getString("status"));
                list.add(req);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
    
    public static List<LeaveRequest> getPendingRequestsForLecturer(int lecturerId) {
    List<LeaveRequest> requests = new ArrayList<>();
        String query = "SELECT lr.*, s.name as student_name FROM leaverequest lr JOIN student s ON lr.student_id = s.student_id WHERE lr.lecturer_id = ? AND lr.status = 'Pending'";

        try (Connection con = LoginDao.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, lecturerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                LeaveRequest lr = new LeaveRequest();
                lr.setRequestId(rs.getInt("request_id"));
                lr.setStudentId(rs.getInt("student_id"));
                lr.setStudentName(rs.getString("student_name"));
                lr.setTitle(rs.getString("title"));
                lr.setDescription(rs.getString("description"));
                lr.setProofFilePath(rs.getString("proof_file_path"));
                lr.setCourseCode(rs.getString("course_code"));
                lr.setGroupId(rs.getInt("group_id"));
                lr.setStatus(rs.getString("status"));
                requests.add(lr);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return requests;
    }


}

