inherited SourceDataModule: TSourceDataModule
  inherited TbNivel: TZTable
    object TbNivelCodNivel: TIntegerField
      FieldName = 'CodNivel'
    end
    object TbNivelNomNivel: TWideStringField
      FieldName = 'NomNivel'
      Required = True
      Size = 15
    end
    object TbNivelAbrNivel: TWideStringField
      FieldName = 'AbrNivel'
      Size = 5
    end
  end
  inherited DSMateriaProhibicion: TDataSource
    DataSet = nil
  end
end
