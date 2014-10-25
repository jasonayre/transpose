class Post < ::OpenStruct
  include ::Transpose::Transposable

  transposer "RemotePost", {
    :id => :Id,
    :title => :Title
  }
end
