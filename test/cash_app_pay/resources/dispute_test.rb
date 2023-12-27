# frozen_string_literal: true

require File.expand_path('../../test_helper', __dir__)

class DisputeTest < Test::Unit::TestCase
  def setup
    CashAppPay.api_base = CashAppPay::TestData::API::API_BASE
    CashAppPay.client_id = CashAppPay::TestData::API::CLIENT_ID
    CashAppPay.region = CashAppPay::TestData::API::REGION
    CashAppPay.signature = CashAppPay::TestData::API::SIGNATURE
    CashAppPay.api_key = CashAppPay::TestData::API::API_KEY
  end

  def test_refresh
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/disputes/DSPT_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Dispute.make_dispute.to_json)
    dispute = CashAppPay::Dispute.new(id: 'DSPT_1')
    dispute.refresh
    assert_equal 'FR10', dispute.reason
  end

  def test_retrieve
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/disputes/DSPT_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Dispute.make_dispute.to_json)
    dispute = CashAppPay::Dispute.retrieve('DSPT_1')
    assert_equal 'FR10', dispute.reason
  end

  def test_list
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/disputes?limit=5')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Dispute.make_dispute_list.to_json)
    disputes = CashAppPay::Dispute.list({ limit: 5 })
    assert_equal(Hash[:limit, 5], disputes.filters)
    assert_equal 'FR10', disputes.data[0].reason
    assert_equal 'Cgl0dmNqa3R4MHk=', disputes.cursor
  end

  def test_accept
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/disputes/DSPT_1/accept')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Dispute.make_dispute.to_json)
    dispute = CashAppPay::Dispute.accept('DSPT_1')
    assert_equal 'FR10', dispute.reason

    dispute = CashAppPay::Dispute.new(id: 'DSPT_1').accept
    assert_equal 'FR10', dispute.reason
  end

  def test_challenge
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/disputes/DSPT_1/challenge')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::Dispute.make_dispute.to_json)
    dispute = CashAppPay::Dispute.challenge('DSPT_1')
    assert_equal 'FR10', dispute.reason

    dispute = CashAppPay::Dispute.new(id: 'DSPT_1').challenge
    assert_equal 'FR10', dispute.reason
  end

  def test_list_dispute_evidence; end

  def test_create_dispute_evidence_text
    params = CashAppPay::TestData::DisputeEvidence.make_dispute_evidence_text_params
    stub_request(:post, 'https://sandbox.api.cash.app/network/v1/disputes/DSPT_1/evidence-text')
      .with(
        body: Hash[:evidence, params, :idempotency_key, 'idempotency'].to_json,
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::DisputeEvidence.make_evidence.to_json)
    params_with_idempotency = params.merge(idempotency_key: 'idempotency').dup
    evidence = CashAppPay::Dispute.create_dispute_evidence_text('DSPT_1', params_with_idempotency)
    assert_equal 'GENERIC_EVIDENCE', evidence.category

    params_with_idempotency = params.merge(idempotency_key: 'idempotency').dup
    evidence = CashAppPay::Dispute.new(id: 'DSPT_1').create_dispute_evidence_text(params_with_idempotency)
    assert_equal 'GENERIC_EVIDENCE', evidence.category
  end

  def test_create_dispute_evidence_file; end

  def test_delete_dispute_evidence
    # TODO: FIXME - How can I stub this body?
    # stub_request(:get, 'https://sandbox.api.cash.app/network/v1/disputes/DSPT_1')
    #   .with(
    #     headers: CashAppPay::TestData::API.network_api_headers
    #   )
    #   .to_return(status: 200, body: [])

    #   dispute = CashAppPay::Dispute.new(id: 'DSPT_1')
    #   assert(dispute.delete_dispute_evidence('EVD_1'))
  end

  def test_retrieve_dispute_evidence
    stub_request(:get, 'https://sandbox.api.cash.app/network/v1/disputes/DSPT_1/evidence/EVD_1')
      .with(
        headers: CashAppPay::TestData::API.network_api_headers
      )
      .to_return(status: 200, body: CashAppPay::TestData::DisputeEvidence.make_evidence.to_json)
    evidence = CashAppPay::Dispute.retrieve_dispute_evidence('DSPT_1', 'EVD_1')
    assert_equal 'GENERIC_EVIDENCE', evidence.category

    evidence = CashAppPay::Dispute.new(id: 'DSPT_1').retrieve_dispute_evidence('EVD_1')
    assert_equal 'GENERIC_EVIDENCE', evidence.category
  end
end
