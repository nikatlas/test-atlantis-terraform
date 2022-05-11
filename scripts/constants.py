import enum
from typing import List, Tuple, Type, TypeVar

EnumType = TypeVar("EnumType", bound=enum.Enum)


class StrEnum(str, enum.Enum):
    """Enum in which all values are strings and can be treated as such."""

    @classmethod
    def all(cls: Type[EnumType]) -> List[EnumType]:
        """Gets all possible options from this enum."""
        return [choice for choice in cls]

    @classmethod
    def values(cls) -> List[str]:
        """Gets all possible values from this enum."""

        return [choice.value for choice in cls]

    @classmethod
    def choices(cls) -> List[Tuple[str, str]]:
        """Gets a list of available enum values.

        Returns:
            A list of (value, name) tuples.
        """
        return [(choice.value, choice.name.title()) for choice in cls]

    def __str__(self) -> str:
        """Gets this enum value as a real string."""
        return str(self.value)


class App(StrEnum):
    OLX_BH = "olx-bh"
    OLX_EG = "olx-eg"
    OLX_JO = "olx-jo"
    OLX_KW = "olx-kw"
    OLX_LB = "olx-lb"
    OLX_OM = "olx-om"
    OLX_PK = "olx-pk"
    OLX_QA = "olx-qa"
    OLX_SA = "olx-sa"


class Env(StrEnum):
    LIVE = "production"
    STAGING = "staging"
    DEVELOPMENT = "development"
