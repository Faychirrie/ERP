package com.example.projectV1.Repository.CRM;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.projectV1.Models.CRM.EnquiryGenerationMaster;

@Repository
public interface EnquiryGenerationRepository extends JpaRepository<EnquiryGenerationMaster, Integer> {

    public Optional<EnquiryGenerationMaster> findEnquiryGenerationMasterByVcustomerMobile1(String vcustomer_mobile1);
}