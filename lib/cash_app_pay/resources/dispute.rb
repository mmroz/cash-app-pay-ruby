# frozen_string_literal: true

module CashAppPay
  class Dispute < APIResource
    extend CashAppPay::APIOperations::List
    include CashAppPay::APIOperations::Retrieve

    def self.resource_url
      '/network/v1/disputes'
    end

    def self.object_name
      :dispute
    end

    def accept(opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/disputes/%<dispute>s/accept', { dispute: CGI.escape(self) }),
        params: nil,
        opts: opts
      )
    end

    def self.accept(dispute, opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/disputes/%<dispute>s/accept', { dispute: CGI.escape(dispute) }),
        params: nil,
        opts: opts
      )
    end

    def challenge(opts = {})
      request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/disputes/%<dispute>s/challenge', { dispute: CGI.escape(self) }),
        params: nil,
        opts: opts
      )
    end

    def self.challenge(dispute, opts = {})
      equest_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/disputes/%<dispute>s/challenge', { dispute: CGI.escape(dispute) }),
        params: nil,
        opts: opts
      )
    end

    def list_dispute_evidence(opts = {})
      # request_cash_app_pay_object(
      #   method: :post,
      #   path: format('/network/v1/disputes/%<dispute>s/challenge', { dispute: CGI.escape(self) }),
      #   params: nil,
      #   opts: opts
      # )
    end

    def self.list_dispute_evidence(dispute, opts = {})
      # equest_cash_app_pay_object(
      #   method: :post,
      #   path: format('/network/v1/disputes/%<dispute>s/challenge', { dispute: CGI.escape(dispute) }),
      #   params: nil,
      #   opts: opts
      # )
    end

    def create_dispute_evidence_text(params = {}, opts = {})
      CashAppPay::DisputeEvidence.request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/disputes/%<dispute>s/evidence-text', { dispute: CGI.escape(self) }),
        params: params,
        opts: opts
      )
    end

    def self.create_dispute_evidence_text(_dispute, opts = {})
      CashAppPay::DisputeEvidence.request_cash_app_pay_object(
        method: :post,
        path: format('/network/v1/disputes/%<dispute>s/evidence-text', { dispute: CGI.escape(self) }),
        params: params,
        opts: opts
      )
    end

    def create_dispute_evidence_file(params = {}, opts = {})
      # CashAppPay::DisputeEvidence.request_cash_app_pay_object(
      #   method: :post,
      #   path: format('/network/v1/disputes/%<dispute>s/evidence-text', { dispute: CGI.escape(self) }),
      #   params: params,
      #   opts: opts
      # )
    end

    def self.create_dispute_evidence_file(dispute, opts = {})
      # CashAppPay::DisputeEvidence.request_cash_app_pay_object(
      #   method: :post,
      #   path: format('/network/v1/disputes/%<dispute>s/evidence-text', { dispute: CGI.escape(self) }),
      #   params: params,
      #   opts: opts
      # )
    end

    def delete_dispute_evidence(params = {}, opts = {})
      # CashAppPay::DisputeEvidence.request_cash_app_pay_object(
      #   method: :post,
      #   path: format('/network/v1/disputes/%<dispute>s/evidence-text', { dispute: CGI.escape(self) }),
      #   params: params,
      #   opts: opts
      # )
    end

    def self.delete_dispute_evidence(dispute, opts = {})
      # CashAppPay::DisputeEvidence.request_cash_app_pay_object(
      #   method: :post,
      #   path: format('/network/v1/disputes/%<dispute>s/evidence-text', { dispute: CGI.escape(self) }),
      #   params: params,
      #   opts: opts
      # )
    end

    def retrieve_dispute_evidence(evidence, opts = {})
      CashAppPay::DisputeEvidence.request_cash_app_pay_object(
        method: :get,
        path: format('/network/v1/disputes/%<dispute>s/evidence/%<dispute>s',
                     { dispute: CGI.escape(self), evidence: CGI.escape(evidence) }),
        params: params,
        opts: opts
      )
    end

    def self.retrieve_dispute_evidence(dispute, evidence, opts = {})
      CashAppPay::DisputeEvidence.request_cash_app_pay_object(
        method: :get,
        path: format('/network/v1/disputes/%<dispute>s/evidence-text',
                     { dispute: CGI.escape(dispute), evidence: CGI.escape(evidence) }),
        params: params,
        opts: opts
      )
    end
  end
end
