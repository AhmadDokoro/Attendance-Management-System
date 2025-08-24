package Model;

public class LeaveRequest {
    private int requestId;
    private int studentId;
    private String courseCode;
    private int groupId;
    private int lecturerId;
    private String title;
    private String description;
    private String proofFilePath;
    private String status;
    private String studentName;

    // Constructors
    public LeaveRequest() {}

    public LeaveRequest(int studentId, String courseCode, int groupId, int lecturerId,
                        String title, String description, String proofFilePath, String status) {
        this.studentId = studentId;
        this.courseCode = courseCode;
        this.groupId = groupId;
        this.lecturerId = lecturerId;
        this.title = title;
        this.description = description;
        this.proofFilePath = proofFilePath;
        this.status = status;
    }

    // Getters and Setters
    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getLecturerId() {
        return lecturerId;
    }

    public void setLecturerId(int lecturerId) {
        this.lecturerId = lecturerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProofFilePath() {
        return proofFilePath;
    }

    public void setProofFilePath(String proofFilePath) {
        this.proofFilePath = proofFilePath;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
}
