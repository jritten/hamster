require "spec_helper"
require "hamster/vector"

describe Hamster::Vector do
  describe "#repeated_permutation" do
    before do
      @vector = Hamster.vector(1,2,3,4)
    end

    context "without a block" do
      context "and without argument" do
        it "returns an Enumerator of all repeated permutations" do
          @vector.repeated_permutation.class.should be(Enumerator)
          @vector.repeated_permutation.to_a.sort.should eql(@vector.to_a.repeated_permutation(4).to_a.sort)
        end
      end

      context "with an integral argument" do
        it "returns an Enumerator of all repeated permutations of the given length" do
          @vector.repeated_permutation(2).class.should be(Enumerator)
          @vector.repeated_permutation(2).to_a.sort.should eql(@vector.to_a.repeated_permutation(2).to_a.sort)
          @vector.repeated_permutation(3).class.should be(Enumerator)
          @vector.repeated_permutation(3).to_a.sort.should eql(@vector.to_a.repeated_permutation(3).to_a.sort)
        end
      end
    end

    context "with a block" do
      it "returns self" do
        @vector.repeated_permutation {}.should be(@vector)
      end

      context "on an empty vector" do
        it "yields the empty permutation" do
          yielded = []
          Hamster.vector.repeated_permutation { |obj| yielded << obj }
          yielded.should eql([[]])
        end
      end

      context "with an argument of zero" do
        it "yields the empty permutation" do
          yielded = []
          @vector.repeated_permutation(0) { |obj| yielded << obj }
          yielded.should eql([[]])
        end
      end

      context "with no argument" do
        it "yields all repeated permutations" do
          yielded = []
          Hamster.vector(1,2,3).repeated_permutation { |obj| yielded << obj }
          yielded.sort.should eql([[1,1,1], [1,1,2], [1,1,3], [1,2,1], [1,2,2],
            [1,2,3], [1,3,1], [1,3,2], [1,3,3], [2,1,1], [2,1,2], [2,1,3], [2,2,1],
            [2,2,2], [2,2,3], [2,3,1], [2,3,2], [2,3,3], [3,1,1], [3,1,2], [3,1,3],
            [3,2,1], [3,2,2], [3,2,3], [3,3,1], [3,3,2], [3,3,3]])
        end
      end

      context "with a positive integral argument" do
        it "yields all repeated permutations of the given length" do
          yielded = []
          @vector.repeated_permutation(2) { |obj| yielded << obj }
          yielded.sort.should eql([[1,1], [1,2], [1,3], [1,4], [2,1], [2,2], [2,3], [2,4],
            [3,1], [3,2], [3,3], [3,4], [4,1], [4,2], [4,3], [4,4]])
        end
      end
    end

    it "handles duplicate elements correctly" do
    Hamster.vector(10,11,10).repeated_permutation(2).sort.should eql([[10, 10], [10, 10],
      [10, 10], [10, 10], [10, 11], [10, 11], [11, 10], [11, 10], [11, 11]])
    end

    it "allows permutations larger than the number of elements" do
      Hamster.vector(1,2).repeated_permutation(3).sort.should eql(
        [[1, 1, 1], [1, 1, 2], [1, 2, 1],
         [1, 2, 2], [2, 1, 1], [2, 1, 2],
         [2, 2, 1], [2, 2, 2]])
    end
  end
end