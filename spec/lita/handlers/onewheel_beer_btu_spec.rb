require_relative '../../spec_helper'

describe Lita::Handlers::OnewheelBeerBtu, lita_handler: true do
  it { is_expected.to route_command('btu') }
  it { is_expected.to route_command('btu 4') }
  it { is_expected.to route_command('btu <$4') }
  it { is_expected.to route_command('btu <=$4') }
  it { is_expected.to route_command('btu >4%') }
  it { is_expected.to route_command('btu >=4%') }
  it { is_expected.to route_command('btuabvhigh') }
  it { is_expected.to route_command('btuabvlow') }

  before do
    mock = File.open('spec/fixtures/btu.pdf').read
    allow(OnewheelBeerBtu).to receive(:method_name) { mock }
  end

  it 'shows the taps' do
    send_command 'btu'
    expect(replies.last).to include("btu taps: 1) Brick House Blonde - 5.0%  2) Seismic IPA - 6.2%  3) Rip Saw Red - 6.5%  4) Steel Bridge Stout")
  end

  it 'displays details for tap brick' do
    send_command 'btu brick'
    expect(replies.last).to eq("btu's tap 1) Brick House Blonde - 5.0% ABV 18 IBU - She’s blonde and refreshing! She’s mighty mighty! Brewed with perfect proportions of Northwest hops and malts for a beer that makes an old man wish for younger days. This session ale lets it all hang out with easy drinkability and a light malt finish. …what a winning hand!")
  end

  it 'displays details for tap 7' do
    send_command 'btu 7'
    expect(replies.last).to include("btu's tap 7) Chocolate Blood Orange Candi Biere - 5.9% ABV 24 IBU - This brew is inspired by the")
  end

  it 'displays details for tap 5' do
    send_command 'btu 5'
    puts replies.last
    expect(replies.last).to include("btu's tap 5) You’re A Peach, Hon’ - 5.9% ABV 18 IBU - Matt, our human brewing machine, ")
  end
end
