require_relative '../../spec_helper'

describe Nsqlookupd do

  before do
    @cluster = NsqCluster.new(nsqd_count: 1, nsqlookupd_count: 1)
    @nsqd = @cluster.nsqd.first
    @nsqlookupd = @cluster.nsqlookupd.first
    sleep 0.1
  end

  after do
    @cluster.destroy
  end

  describe 'api endpoints' do
    describe '#ping' do
      it 'should return status 200' do
        expect(@nsqlookupd.ping.code).to eql('200')
      end
    end

    describe '#info' do
      it 'should return status 200' do
        expect(@nsqlookupd.info.code).to eql('200')
      end
    end

    describe '#nodes' do
      it 'should return status 200' do
        expect(@nsqlookupd.nodes.code).to eql('200')
      end
    end

    describe '#topic' do
      it 'should return status 200' do
        expect(@nsqlookupd.topics.code).to eql('200')
      end
    end

    describe '#channels' do
      it 'should return status 200' do
        expect(@nsqlookupd.channels('default').code).to eql('200')
      end
    end

    describe '#lookup' do
      describe 'an existing topic' do
        before do
          @nsqd.create(topic: 'test')
        end

        it 'should return status 200' do
          expect(@nsqlookupd.lookup('test').code).to eql('200')
        end
      end

      describe 'a non-existant topic' do
        it 'should return status 500' do
          expect(@nsqlookupd.lookup('wtf').code).to eql('500')
        end
      end
    end
  end
end
