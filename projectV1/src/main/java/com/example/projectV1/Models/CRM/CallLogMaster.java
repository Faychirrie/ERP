package com.example.projectV1.Models.CRM;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table
public class CallLogMaster {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private int ienquiryId;
    private String vphoneNumber;
    private Date dcallDate;
    private String vduration;
    private String vremarks;
    private String vcreatedBy;

    public CallLogMaster() {
    }

    public CallLogMaster(long id, int ienquiryId, String vphoneNumber, Date dcallDate, String vduration,
            String vremarks,
            String vcreatedBy) {
        this.id = id;
        this.ienquiryId = ienquiryId;
        this.vphoneNumber = vphoneNumber;
        this.dcallDate = dcallDate;
        this.vduration = vduration;
        this.vremarks = vremarks;
        this.vcreatedBy = vcreatedBy;
    }

    public CallLogMaster(int ienquiryId, String vphoneNumber, Date dcallDate, String vduration, String vremarks,
            String vcreatedBy) {
        this.ienquiryId = ienquiryId;
        this.vphoneNumber = vphoneNumber;
        this.dcallDate = dcallDate;
        this.vduration = vduration;
        this.vremarks = vremarks;
        this.vcreatedBy = vcreatedBy;
    }

    @Override
    public String toString() {
        return "CallLogMaster [id=" + id + ", ienquiryId=" + ienquiryId + ", vphoneNumber=" + vphoneNumber
                + ", dcallDate="
                + dcallDate + ", vduration=" + vduration + ", vremarks=" + vremarks + ", vcreatedBy=" + vcreatedBy
                + "]";
    }

    /**
     * @return long return the id
     */
    public long getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(long id) {
        this.id = id;
    }

    /**
     * @return int return the ienquiryId
     */
    public int getIenquiryId() {
        return ienquiryId;
    }

    /**
     * @param ienquiryId the ienquiryId to set
     */
    public void setIenquiryId(int ienquiryId) {
        this.ienquiryId = ienquiryId;
    }

    /**
     * @return String return the vphoneNumber
     */
    public String getVphoneNumber() {
        return vphoneNumber;
    }

    /**
     * @param vphoneNumber the vphoneNumber to set
     */
    public void setVphoneNumber(String vphoneNumber) {
        this.vphoneNumber = vphoneNumber;
    }

    /**
     * @return Date return the dcallDate
     */
    public Date getDcallDate() {
        return dcallDate;
    }

    /**
     * @param dcallDate the dcallDate to set
     */
    public void setDcallDate(Date dcallDate) {
        this.dcallDate = dcallDate;
    }

    /**
     * @return String return the vduration
     */
    public String getVduration() {
        return vduration;
    }

    /**
     * @param vduration the vduration to set
     */
    public void setVduration(String vduration) {
        this.vduration = vduration;
    }

    /**
     * @return String return the vremarks
     */
    public String getVremarks() {
        return vremarks;
    }

    /**
     * @param vremarks the vremarks to set
     */
    public void setVremarks(String vremarks) {
        this.vremarks = vremarks;
    }

    /**
     * @return String return the vcreatedBy
     */
    public String getVcreatedBy() {
        return vcreatedBy;
    }

    /**
     * @param vcreatedBy the vcreatedBy to set
     */
    public void setVcreatedBy(String vcreatedBy) {
        this.vcreatedBy = vcreatedBy;
    }

}
