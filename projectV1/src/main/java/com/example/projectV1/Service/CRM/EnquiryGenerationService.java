package com.example.projectV1.Service.CRM;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.projectV1.Models.CRM.EnquiryGenerationMaster;
import com.example.projectV1.Repository.CRM.EnquiryGenerationRepository;

import jakarta.transaction.Transactional;

@Service
public class EnquiryGenerationService {
    EnquiryGenerationRepository crmRepository;

    public EnquiryGenerationService(EnquiryGenerationRepository crmRepository) {
        this.crmRepository = crmRepository;
    }

    public List<EnquiryGenerationMaster> getEnquiryList() {
        return crmRepository.findAll();
    }

    public void addNewEnquiry(EnquiryGenerationMaster enquiryGenerationMaster) {
        Optional<EnquiryGenerationMaster> vcustomer_mobile1 = crmRepository
                .findEnquiryGenerationMasterByVcustomerMobile1(enquiryGenerationMaster.getVcustomerMobile1());
        if (vcustomer_mobile1.isPresent()) {
            throw new IllegalStateException("Customer With that phone number alreadyExist");
        }
        crmRepository.save(enquiryGenerationMaster);
    }

    @Transactional
    public void deleteEnquiry(int id, char cstatus) {
        EnquiryGenerationMaster enquiryGenerationMaster = crmRepository.findById(id)
                .orElseThrow(() -> new IllegalStateException("Enquiry with this id does not exist"));
        if (cstatus != 0) {
            enquiryGenerationMaster.setCstatus(cstatus);
        }
    }

    @Transactional
    public void updateEnquiry(EnquiryGenerationMaster enquiryGenerationMaster) {
        EnquiryGenerationMaster egm = crmRepository.findById(enquiryGenerationMaster.getId())
                .orElseThrow(() -> new IllegalStateException("Enquiry with this id does not exist"));
        if (enquiryGenerationMaster.getVcustomer_name() != null
                && !enquiryGenerationMaster.getVcustomer_name().isEmpty()) {
            egm.setVcustomer_name(enquiryGenerationMaster.getVcustomer_name());

        }

    }

}