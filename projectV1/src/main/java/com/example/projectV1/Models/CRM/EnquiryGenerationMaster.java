package com.example.projectV1.Models.CRM;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;

@Entity // for hibernate
@Table(name = "Enquiry_Generation_Master")
public class EnquiryGenerationMaster {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String vcustomer_name;
    private String vcustomer_address;
    private String vpermanent_city;
    @Column(name = "vcustomer_mobile1")
    private String vcustomerMobile1;
    private String vcustomer_mobile2;
    private String vcustomer_email_address;
    private String vcustomer_email_address2;
    private String vproperty_enquiry_code;
    private String vtemp_customer_code;
    private Date denquiry_date;
    private int iproperty_id;
    private int idivision_category_id;
    private int ipayment_terms_id;
    private double mour_offer;
    private int ilead_source;
    private int ibusiness_area_id;
    private String vremarks;
    private String vagent_code;
    private String vlead_by;
    private String vcreated_by;
    private Date dcreated_date;
    private String vupdated_by;
    private Date dupdated_date;
    private char cstatus;
    private char cenquiry_status;
    private char clead_qualification;
    private int icountry_id;
    private int ibillboard_location_id;
    private int ienquiry_detail_id;

    public EnquiryGenerationMaster() {
    }

    public EnquiryGenerationMaster(String vcustomer_name, String vcustomer_address, String vpermanent_city,
            String vcustomerMobile1, String vcustomer_mobile2, String vcustomer_email_address,
            String vcustomer_email_address2, String vproperty_enquiry_code, String vtemp_customer_code,
            Date denquiry_date, int iproperty_id, int idivision_category_id, int ipayment_terms_id, double mour_offer,
            int ilead_source, int ibusiness_area_id, String vremarks, String vagent_code, String vlead_by,
            String vcreated_by, Date dcreated_date, String vupdated_by, Date dupdated_date, char cstatus,
            char cenquiry_status, char clead_qualification, int icountry_id, int ibillboard_location_id,
            int ienquiry_detail_id) {
        this.vcustomer_name = vcustomer_name;
        this.vcustomer_address = vcustomer_address;
        this.vpermanent_city = vpermanent_city;
        this.vcustomerMobile1 = vcustomerMobile1;
        this.vcustomer_mobile2 = vcustomer_mobile2;
        this.vcustomer_email_address = vcustomer_email_address;
        this.vcustomer_email_address2 = vcustomer_email_address2;
        this.vproperty_enquiry_code = vproperty_enquiry_code;
        this.vtemp_customer_code = vtemp_customer_code;
        this.denquiry_date = denquiry_date;
        this.iproperty_id = iproperty_id;
        this.idivision_category_id = idivision_category_id;
        this.ipayment_terms_id = ipayment_terms_id;
        this.mour_offer = mour_offer;
        this.ilead_source = ilead_source;
        this.ibusiness_area_id = ibusiness_area_id;
        this.vremarks = vremarks;
        this.vagent_code = vagent_code;
        this.vlead_by = vlead_by;
        this.vcreated_by = vcreated_by;
        this.dcreated_date = dcreated_date;
        this.vupdated_by = vupdated_by;
        this.dupdated_date = dupdated_date;
        this.cstatus = cstatus;
        this.cenquiry_status = cenquiry_status;
        this.clead_qualification = clead_qualification;
        this.icountry_id = icountry_id;
        this.ibillboard_location_id = ibillboard_location_id;
        this.ienquiry_detail_id = ienquiry_detail_id;
    }

    public EnquiryGenerationMaster(int id, String vcustomer_name, String vcustomer_address, String vpermanent_city,
            String vcustomerMobile1, String vcustomer_mobile2, String vcustomer_email_address,
            String vcustomer_email_address2, String vproperty_enquiry_code, String vtemp_customer_code,
            Date denquiry_date, int iproperty_id, int idivision_category_id, int ipayment_terms_id, double mour_offer,
            int ilead_source, int ibusiness_area_id, String vremarks, String vagent_code, String vlead_by,
            String vcreated_by, Date dcreated_date, String vupdated_by, Date dupdated_date, char cstatus,
            char cenquiry_status, char clead_qualification, int icountry_id, int ibillboard_location_id,
            int ienquiry_detail_id) {
        this.id = id;
        this.vcustomer_name = vcustomer_name;
        this.vcustomer_address = vcustomer_address;
        this.vpermanent_city = vpermanent_city;
        this.vcustomerMobile1 = vcustomerMobile1;
        this.vcustomer_mobile2 = vcustomer_mobile2;
        this.vcustomer_email_address = vcustomer_email_address;
        this.vcustomer_email_address2 = vcustomer_email_address2;
        this.vproperty_enquiry_code = vproperty_enquiry_code;
        this.vtemp_customer_code = vtemp_customer_code;
        this.denquiry_date = denquiry_date;
        this.iproperty_id = iproperty_id;
        this.idivision_category_id = idivision_category_id;
        this.ipayment_terms_id = ipayment_terms_id;
        this.mour_offer = mour_offer;
        this.ilead_source = ilead_source;
        this.ibusiness_area_id = ibusiness_area_id;
        this.vremarks = vremarks;
        this.vagent_code = vagent_code;
        this.vlead_by = vlead_by;
        this.vcreated_by = vcreated_by;
        this.dcreated_date = dcreated_date;
        this.vupdated_by = vupdated_by;
        this.dupdated_date = dupdated_date;
        this.cstatus = cstatus;
        this.cenquiry_status = cenquiry_status;
        this.clead_qualification = clead_qualification;
        this.icountry_id = icountry_id;
        this.ibillboard_location_id = ibillboard_location_id;
        this.ienquiry_detail_id = ienquiry_detail_id;
    }

    /**
     * @return int return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return String return the vcustomer_name
     */
    public String getVcustomer_name() {
        return vcustomer_name;
    }

    /**
     * @param vcustomer_name the vcustomer_name to set
     */
    public void setVcustomer_name(String vcustomer_name) {
        this.vcustomer_name = vcustomer_name;
    }

    /**
     * @return String return the vcustomer_address
     */
    public String getVcustomer_address() {
        return vcustomer_address;
    }

    /**
     * @param vcustomer_address the vcustomer_address to set
     */
    public void setVcustomer_address(String vcustomer_address) {
        this.vcustomer_address = vcustomer_address;
    }

    /**
     * @return String return the vpermanent_city
     */
    public String getVpermanent_city() {
        return vpermanent_city;
    }

    /**
     * @param vpermanent_city the vpermanent_city to set
     */
    public void setVpermanent_city(String vpermanent_city) {
        this.vpermanent_city = vpermanent_city;
    }

    /**
     * @return String return the vcustomer_mobile2
     */
    public String getVcustomer_mobile2() {
        return vcustomer_mobile2;
    }

    /**
     * @param vcustomer_mobile2 the vcustomer_mobile2 to set
     */
    public void setVcustomer_mobile2(String vcustomer_mobile2) {
        this.vcustomer_mobile2 = vcustomer_mobile2;
    }

    /**
     * @return String return the vcustomer_email_address
     */
    public String getVcustomer_email_address() {
        return vcustomer_email_address;
    }

    /**
     * @param vcustomer_email_address the vcustomer_email_address to set
     */
    public void setVcustomer_email_address(String vcustomer_email_address) {
        this.vcustomer_email_address = vcustomer_email_address;
    }

    /**
     * @return String return the vcustomer_email_address2
     */
    public String getVcustomer_email_address2() {
        return vcustomer_email_address2;
    }

    /**
     * @param vcustomer_email_address2 the vcustomer_email_address2 to set
     */
    public void setVcustomer_email_address2(String vcustomer_email_address2) {
        this.vcustomer_email_address2 = vcustomer_email_address2;
    }

    /**
     * @return String return the vproperty_enquiry_code
     */
    public String getVproperty_enquiry_code() {
        return vproperty_enquiry_code;
    }

    /**
     * @param vproperty_enquiry_code the vproperty_enquiry_code to set
     */
    public void setVproperty_enquiry_code(String vproperty_enquiry_code) {
        this.vproperty_enquiry_code = vproperty_enquiry_code;
    }

    /**
     * @return String return the vtemp_customer_code
     */
    public String getVtemp_customer_code() {
        return vtemp_customer_code;
    }

    /**
     * @param vtemp_customer_code the vtemp_customer_code to set
     */
    public void setVtemp_customer_code(String vtemp_customer_code) {
        this.vtemp_customer_code = vtemp_customer_code;
    }

    /**
     * @return Date return the denquiry_date
     */
    public Date getDenquiry_date() {
        return denquiry_date;
    }

    /**
     * @param denquiry_date the denquiry_date to set
     */
    public void setDenquiry_date(Date denquiry_date) {
        this.denquiry_date = denquiry_date;
    }

    /**
     * @return int return the iproperty_id
     */
    public int getIproperty_id() {
        return iproperty_id;
    }

    /**
     * @param iproperty_id the iproperty_id to set
     */
    public void setIproperty_id(int iproperty_id) {
        this.iproperty_id = iproperty_id;
    }

    /**
     * @return int return the idivision_category_id
     */
    public int getIdivision_category_id() {
        return idivision_category_id;
    }

    /**
     * @param idivision_category_id the idivision_category_id to set
     */
    public void setIdivision_category_id(int idivision_category_id) {
        this.idivision_category_id = idivision_category_id;
    }

    /**
     * @return int return the ipayment_terms_id
     */
    public int getIpayment_terms_id() {
        return ipayment_terms_id;
    }

    /**
     * @param ipayment_terms_id the ipayment_terms_id to set
     */
    public void setIpayment_terms_id(int ipayment_terms_id) {
        this.ipayment_terms_id = ipayment_terms_id;
    }

    /**
     * @return double return the mour_offer
     */
    public double getMour_offer() {
        return mour_offer;
    }

    /**
     * @param mour_offer the mour_offer to set
     */
    public void setMour_offer(double mour_offer) {
        this.mour_offer = mour_offer;
    }

    /**
     * @return int return the ilead_source
     */
    public int getIlead_source() {
        return ilead_source;
    }

    /**
     * @param ilead_source the ilead_source to set
     */
    public void setIlead_source(int ilead_source) {
        this.ilead_source = ilead_source;
    }

    /**
     * @return int return the ibusiness_area_id
     */
    public int getIbusiness_area_id() {
        return ibusiness_area_id;
    }

    /**
     * @param ibusiness_area_id the ibusiness_area_id to set
     */
    public void setIbusiness_area_id(int ibusiness_area_id) {
        this.ibusiness_area_id = ibusiness_area_id;
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
     * @return String return the vagent_code
     */
    public String getVagent_code() {
        return vagent_code;
    }

    /**
     * @param vagent_code the vagent_code to set
     */
    public void setVagent_code(String vagent_code) {
        this.vagent_code = vagent_code;
    }

    /**
     * @return String return the vlead_by
     */
    public String getVlead_by() {
        return vlead_by;
    }

    /**
     * @param vlead_by the vlead_by to set
     */
    public void setVlead_by(String vlead_by) {
        this.vlead_by = vlead_by;
    }

    /**
     * @return String return the vcreated_by
     */
    public String getVcreated_by() {
        return vcreated_by;
    }

    /**
     * @param vcreated_by the vcreated_by to set
     */
    public void setVcreated_by(String vcreated_by) {
        this.vcreated_by = vcreated_by;
    }

    /**
     * @return Date return the dcreated_date
     */
    public Date getDcreated_date() {
        return dcreated_date;
    }

    /**
     * @param dcreated_date the dcreated_date to set
     */
    public void setDcreated_date(Date dcreated_date) {
        this.dcreated_date = dcreated_date;
    }

    /**
     * @return String return the vupdated_by
     */
    public String getVupdated_by() {
        return vupdated_by;
    }

    /**
     * @param vupdated_by the vupdated_by to set
     */
    public void setVupdated_by(String vupdated_by) {
        this.vupdated_by = vupdated_by;
    }

    /**
     * @return Date return the dupdated_date
     */
    public Date getDupdated_date() {
        return dupdated_date;
    }

    /**
     * @param dupdated_date the dupdated_date to set
     */
    public void setDupdated_date(Date dupdated_date) {
        this.dupdated_date = dupdated_date;
    }

    /**
     * @return char return the cstatus
     */
    public char getCstatus() {
        return cstatus;
    }

    /**
     * @param cstatus the cstatus to set
     */
    public void setCstatus(char cstatus) {
        this.cstatus = cstatus;
    }

    /**
     * @return char return the cenquiry_status
     */
    public char getCenquiry_status() {
        return cenquiry_status;
    }

    /**
     * @param cenquiry_status the cenquiry_status to set
     */
    public void setCenquiry_status(char cenquiry_status) {
        this.cenquiry_status = cenquiry_status;
    }

    /**
     * @return char return the clead_qualification
     */
    public char getClead_qualification() {
        return clead_qualification;
    }

    /**
     * @param clead_qualification the clead_qualification to set
     */
    public void setClead_qualification(char clead_qualification) {
        this.clead_qualification = clead_qualification;
    }

    /**
     * @return int return the icountry_id
     */
    public int getIcountry_id() {
        return icountry_id;
    }

    /**
     * @param icountry_id the icountry_id to set
     */
    public void setIcountry_id(int icountry_id) {
        this.icountry_id = icountry_id;
    }

    /**
     * @return int return the ibillboard_location_id
     */
    public int getIbillboard_location_id() {
        return ibillboard_location_id;
    }

    /**
     * @param ibillboard_location_id the ibillboard_location_id to set
     */
    public void setIbillboard_location_id(int ibillboard_location_id) {
        this.ibillboard_location_id = ibillboard_location_id;
    }

    /**
     * @return int return the ienquiry_detail_id
     */
    public int getIenquiry_detail_id() {
        return ienquiry_detail_id;
    }

    /**
     * @param ienquiry_detail_id the ienquiry_detail_id to set
     */
    public void setIenquiry_detail_id(int ienquiry_detail_id) {
        this.ienquiry_detail_id = ienquiry_detail_id;
    }

    /**
     * @return String return the vcustomerMobile1
     */
    public String getVcustomerMobile1() {
        return vcustomerMobile1;
    }

    /**
     * @param vcustomerMobile1 the vcustomerMobile1 to set
     */
    public void setVcustomerMobile1(String vcustomerMobile1) {
        this.vcustomerMobile1 = vcustomerMobile1;
    }

    @Override
    public String toString() {
        return "EnquiryGenerationMaster [id=" + id + ", vcustomer_name=" + vcustomer_name + ", vcustomer_address="
                + vcustomer_address + ", vpermanent_city=" + vpermanent_city + ", vcustomerMobile1=" + vcustomerMobile1
                + ", vcustomer_mobile2=" + vcustomer_mobile2 + ", vcustomer_email_address=" + vcustomer_email_address
                + ", vcustomer_email_address2=" + vcustomer_email_address2 + ", vproperty_enquiry_code="
                + vproperty_enquiry_code + ", vtemp_customer_code=" + vtemp_customer_code + ", denquiry_date="
                + denquiry_date + ", iproperty_id=" + iproperty_id + ", idivision_category_id=" + idivision_category_id
                + ", ipayment_terms_id=" + ipayment_terms_id + ", mour_offer=" + mour_offer + ", ilead_source="
                + ilead_source + ", ibusiness_area_id=" + ibusiness_area_id + ", vremarks=" + vremarks
                + ", vagent_code=" + vagent_code + ", vlead_by=" + vlead_by + ", vcreated_by=" + vcreated_by
                + ", dcreated_date=" + dcreated_date + ", vupdated_by=" + vupdated_by + ", dupdated_date="
                + dupdated_date + ", cstatus=" + cstatus + ", cenquiry_status=" + cenquiry_status
                + ", clead_qualification=" + clead_qualification + ", icountry_id=" + icountry_id
                + ", ibillboard_location_id=" + ibillboard_location_id + ", ienquiry_detail_id=" + ienquiry_detail_id
                + "]";
    }

}