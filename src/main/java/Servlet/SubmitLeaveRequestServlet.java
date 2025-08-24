package Servlet;

import DAO.LeaveRequestDao;
import Model.LeaveRequest;
import Model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,    // 1 MB
                 maxFileSize = 1024 * 1024 * 10,     // 10 MB
                 maxRequestSize = 1024 * 1024 * 20)  // 20 MB
public class SubmitLeaveRequestServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("Student");

        if (student == null) {
            response.sendRedirect("../Login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String courseCode = request.getParameter("course_code");
        String groupIdParam = request.getParameter("group_id");
        String lecturerIdParam = request.getParameter("lecturer_id");
        Part filePart = request.getPart("proof");

        int groupId = Integer.parseInt(groupIdParam);
        int lecturerId = Integer.parseInt(lecturerIdParam);

        // ✅ Use your actual project /proofs folder (inside Web Pages)
        String uploadPath = getServletContext().getRealPath("/proofs");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Rename to avoid file name conflict
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uniqueFileName = System.currentTimeMillis() + "_" + originalFileName;
        String filePath = uploadPath + File.separator + uniqueFileName;

        // Save the file
        filePart.write(filePath);

        // ✅ Save only the relative path (this will match /proofs/filename.jpg)
        LeaveRequest leaveRequest = new LeaveRequest();
        leaveRequest.setStudentId(student.getId());
        leaveRequest.setCourseCode(courseCode);
        leaveRequest.setGroupId(groupId);
        leaveRequest.setLecturerId(lecturerId);
        leaveRequest.setTitle(title);
        leaveRequest.setDescription(description);
        leaveRequest.setProofFilePath("proofs/" + uniqueFileName);
        leaveRequest.setStatus("Pending");

        boolean success = LeaveRequestDao.submitLeaveRequest(leaveRequest);

        if (success) {
            response.sendRedirect("StudentLeaveStatusServlet");
        } else {
            response.getWriter().println("Failed to submit leave request.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles leave request submission and saves file to /proofs folder.";
    }
}
