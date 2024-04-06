console.log("bgit-accounging/application.js loaded")

function AmountsController(formSelector, nestedFieldsContainerSelector) {
  this.formSelector = formSelector;
  this.nestedFieldsContainerSelector = nestedFieldsContainerSelector;

  this.init = function() {
    console.log("AmountsController.init()")
    this.e = $(this.formSelector);
    this.nestedFieldsContainer = $(this.nestedFieldsContainerSelector);
    this.registerEventHandlers();
    this.fieldsTemplate = this.cloneFields();
  }

  this.cloneFields = function() {
    console.log("AmountsController.cloneFields()")
    var clonedFields = this.nestedFieldsContainer.find(".nested-fields").first().clone();
    // remove values from cloned fields
    clonedFields.find("input").val("");
    // unselect values from cloned fields
    clonedFields.find("select").val(null).trigger('change');
    // uncheck values from cloned fields
    clonedFields.find("input[type=checkbox]").prop('checked', false);

    return clonedFields;
  }

  this.registerEventHandlers = function() {
    console.log("AmountsController.registerEventHandlers()")
    $(document).on("click", this.formSelector + " " + this.nestedFieldsContainerSelector + " .link_to_remove_association", this.removeAssociated.bind(this));
    $(document).on("click", this.formSelector + " " + this.nestedFieldsContainerSelector + " .link_to_add_association", this.addAssociated.bind(this));
  }

  this.addAssociated = function(event) {
    console.log("AmountsController.addAssociated()")
    this.nestedFieldsContainer.find(".links").before(this.fieldsTemplate.clone());
  }

  this.removeAssociated = function(event) {
    console.log("AmountsController.removeAssociated()")
    var link = $(event.target);
    var nestedFields = link.closest(".nested-fields");
    nestedFields.remove();
  }
}

function TaxCalculationsController(containerSelector) {
  this.containerSelector = containerSelector;
  this.subContainerSelector = ".nested-fields"

  this.init = function() {
    console.log("TaxCalculationsController.init()")
    this.container = $(this.containerSelector);
    this.registerEventHandlers();
  }

  this.registerEventHandlers = function() {
    console.log("TaxCalculationsController.registerEventHandlers()")
    $(document).on("change", this.containerSelector + " .tax_rate_percentage", this.calculateTaxAmount.bind(this));
    $(document).on("change", this.containerSelector + " .net_amount", this.calculateTaxAmount.bind(this));
    $(document).on("keyup", this.containerSelector + " .net_amount", this.calculateTaxAmount.bind(this));
  }

  this.calculateTaxAmount = function(event) {
    console.log("TaxCalculationsController.calculateTaxAmount()")

    // get the nested fields container
    var subContainer = $(event.target).closest(this.subContainerSelector);

    var netAmount = subContainer.find(".net_amount").val().replace(",", ".");

    var taxRatePercentage = subContainer.find(".tax_rate_percentage").val();
    var taxAmount = (netAmount * taxRatePercentage / 100).toFixed(2);

    var formatter = new Intl.NumberFormat('de-DE');
    subContainer.find(".tax_amount").val(formatter.format(taxAmount));
  }
}


function AssignVoucherServiceFormController(selector) {
  this.selector = selector;

  this.init = function() {
    console.log("AssignVoucherServiceFormController.init()")
    this.e = $(this.selector);

    this.amountsController = new AmountsController(this.selector, "#amounts");
    this.amountsController.init();

    this.taxCalculationsController = new TaxCalculationsController("#amounts");
    this.taxCalculationsController.init();
  }
}

$(document).ready(function() {
  var asfc = new AssignVoucherServiceFormController("#new_vouchers_assign_voucher_service")
  asfc.init();
});
