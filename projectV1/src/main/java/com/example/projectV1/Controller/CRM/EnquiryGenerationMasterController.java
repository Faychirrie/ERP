package com.example.projectV1.Controller.CRM;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.projectV1.Models.CRM.EnquiryGenerationMaster;
import com.example.projectV1.Service.CRM.EnquiryGenerationService;

@RestController
@RequestMapping(path = "/crm/enquiry")
public class EnquiryGenerationMasterController {
    private final EnquiryGenerationService enquiryGenerationService;

    @Autowired // avoids the use of new when creation constructors
    public EnquiryGenerationMasterController(EnquiryGenerationService enquiryGenerationService) {
        this.enquiryGenerationService = enquiryGenerationService;
    }

    @GetMapping
    public List<EnquiryGenerationMaster> getEnquiryList() {
        return enquiryGenerationService.getEnquiryList();
    }

    @PostMapping
    public void addEnquiry(@RequestBody EnquiryGenerationMaster enquiryGenerationMaster) {
        enquiryGenerationService.addNewEnquiry(enquiryGenerationMaster);
    }

    @PutMapping(path = "{enquiry_id}")
    public void deleteEnquiry(@PathVariable("enquiry_id") int id, @RequestParam(required = true) char cstatus) {
        enquiryGenerationService.deleteEnquiry(id, cstatus);
    }

    @PutMapping
    public void updateEnquiry(@RequestBody EnquiryGenerationMaster enquiryGenerationMaster) {
        enquiryGenerationService.updateEnquiry(enquiryGenerationMaster);
    }

}
