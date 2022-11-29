import { LightningElement } from 'lwc';
import SendSMSCtrl from "@salesforce/apex/SendSMSCtrl.SendSMS";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

 
export default class SendSMSLWC extends LightningElement {
    smsBody;
    toPhoneNo;
 
    sendSMS(){
        let inputFields = this.template.querySelectorAll('.fieldvalidate');
        inputFields.forEach(inputField => {
            if(inputField.name == "toPhoneNo"){
                this.toPhoneNo = inputField.value;
            } else if(inputField.name == "smsBody"){
                this.smsBody = inputField.value;
            } else if(inputField.name == "fromPhNumber"){
                this.fromPhNumber = inputField.value;
            }
        });
 
        this.handleSpinner();
            SendSMSCtrl({phoneNo : this.toPhoneNo, smsBody : this.smsBody, fromPhNumber : this.fromPhNumber})
            .then(result => {
                console.log(result);
 
                const evt = new ShowToastEvent({
                    title: "Great!",
                    message: result,
                    variant: "success",
                });
                this.dispatchEvent(evt);
 
                this.handleSpinner();
            })
            .catch((error) => {
                const evt = new ShowToastEvent({
                    title: "Sorry!",
                    message: error.body.message,
                    variant: "error",
                });
                this.dispatchEvent(evt);
                this.handleSpinner();
            })
    }
 
    handleSpinner(){
        this.showSpinner = !this.showSpinner;
    }
}