RSpec.describe Contractor::SetUpProject do

  context 'contractor' do
    let(:project_details) { JSON.parse(File.read('bin/project_details.json')) }

    it "should match the project Module name" do
      self_module = self.class.to_s.split("::").last
      expect(self_module).to eq(project_details["module"])
    end

    it "should match the project Spec name" do
      self_spec = self.class.description
      expect(self_spec).to eq(project_details["spec"])
    end
  end
end
