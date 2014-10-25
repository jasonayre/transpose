class RemotePost < ::OpenStruct
  include ::Transpose::Transposable

  transposer "Post", {
    :Id => :id,
    :Title => :title
  }
end
