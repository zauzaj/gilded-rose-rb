require File.join(File.dirname(__FILE__), 'gilded_rose')

RSpec.configure do |config|
  config.formatter = :documentation
end

describe GildedRose do
  context 'initial example' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq 'foo'
    end
  end
  describe '#update_quality' do
    let(:program) { GildedRose.new([item]) }
    context '#Sulfuras, Hand of Ragnaros' do
      let(:item) { Item.new('Sulfuras, Hand of Ragnaros', 10, 10) }

      context 'being a legendary item' do
        it 'never has to be sold' do
          expect do
            program.update_quality()
          end.to_not change(item, :sell_in)
        end

        it 'never has decreases in Quality' do
          expect do
            program.update_quality()
          end.to_not change(item, :quality)
        end
      end
    end
    context '#Aged Brie' do
      context '#sell_in' do
        let(:item) { Item.new('Aged Brie', 10, 10) }
        it 'should always decreases by 1' do
          expect do
            program.update_quality
          end.to change(item, :sell_in).by(-1)
        end
      end
      context '#sell_in > 0' do
        let(:item) { Item.new('Aged Brie', 10, 10) }
        it 'should increase quality by 1' do
          expect do
            program.update_quality
          end.to change(item, :quality).by(1)
        end
        context '#quality == 50' do
          let(:item) { Item.new('Aged Brie', 10, 50) }
          it 'should not increase quality' do
            expect do
              program.update_quality
            end.to_not change(item, :quality)
          end
        end
      end
      context '#sell_in == 0' do
        let(:item) { Item.new('Aged Brie', 0, 10) }
        it 'should increase quality by 2' do
          expect do
            program.update_quality
          end.to change(item, :quality).by(2)
        end
        context 'quality == 50' do
          let(:item) { Item.new('Aged Brie', 0, 50) }
          it 'should not increase quality' do
            expect do
              program.update_quality
            end.to_not change(item, :quality)
          end
        end
      end
      context '#sell_in == 1' do
        let(:item) { Item.new('Aged Brie', 1, 10) }
        it 'should increase quality by 0' do
          expect do
            program.update_quality
          end.to change(item, :quality).by(1)
        end
        context 'quality == 50' do
          let(:item) { Item.new('Aged Brie', 1, 50) }
          it 'should not increase quality' do
            expect do
              program.update_quality
            end.to_not change(item, :quality)
          end
        end
      end
      context '#sell_in < 0' do
        let(:item) { Item.new('Aged Brie', -1, 10) }
        it 'should increase quality by 2' do
          expect do
            program.update_quality
          end.to change(item, :quality).by(2)
        end
        context 'quality == 50' do
          let(:item) { Item.new('Aged Brie', -1, 50) }
          it 'should not increase quality' do
            expect do
              program.update_quality
            end.to_not change(item, :quality)
          end
        end
      end
    end
    context '#Backstage passes to a TAFKAL80ETC concert' do
      context '#sell_in' do
        let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 10) }
        it 'should always decrease by 1' do
          expect do
            program.update_quality
          end.to change(item, :sell_in).by(-1)
        end
        context '< 0' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10) }
          it 'should drop quality to 0' do
            expect do
              program.update_quality
            end.to change(item, :quality).to(0)
          end
        end
      end
      context '#quality < 50' do
        context '#sell_in < 11 && sell_in < 6' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 10) }
          context 'much space to 50' do
            it 'should increase quality by 3' do
              expect do
                program.update_quality
              end.to change(item, :quality).by(3)
            end
          end
          context '#quality == 49' do
            before { item.quality = 49 }
            it 'should increase quality by 1' do
              expect do
                program.update_quality
              end.to change(item, :quality).by(1)
            end
          end
          context '#quality == 48' do
            before { item.quality = 48 }
            it 'should increase quality by 2' do
              expect do
                program.update_quality
              end.to change(item, :quality).by(2)
            end
          end
        end
        context '#sell_in < 11 && sell_in > 6' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 8, 10) }
          context 'much space to 50' do
            it 'should increase quality by 2' do
              expect do
                program.update_quality
              end.to change(item, :quality).by(2)
            end
          end
          context '#quality == 49' do
            before { item.quality = 49 }
            it 'should increase quality by 3' do
              expect do
                program.update_quality
              end.to change(item, :quality).by(1)
            end
          end
          context '#quality == 48' do
            before { item.quality = 48 }
            it 'should increase quality by 2' do
              expect do
                program.update_quality
              end.to change(item, :quality).by(2)
            end
          end
        end
        context '#sell_in == 11' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 10) }
          context 'much space to 50' do
            it 'should increase quality by 2' do
              expect do
                program.update_quality
              end.to change(item, :quality).by(2)
            end
          end
        end
        context '#sell_in > 11' do
          let(:item) { Item.new('Backstage passes to a TAFKAL80ETC concert', 12, 10) }
          context 'much space to 50' do
            it 'should increase quality by 1' do
              expect do
                program.update_quality
              end.to change(item, :quality).by(1)
            end
          end
        end
      end
    end
  end
end
