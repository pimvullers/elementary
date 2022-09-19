# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A set of system sounds for elementary OS"
HOMEPAGE="https://github.com/elementary/sound-theme"
SRC_URI="https://github.com/elementary/sound-theme/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/sound-theme-${PV}"
