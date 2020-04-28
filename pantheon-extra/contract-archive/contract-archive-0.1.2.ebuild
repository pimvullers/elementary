# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="This package allows you to extract and compress the archive over Contractor"
HOMEPAGE="https://github.com/Dirli/contract-archive"
SRC_URI="https://github.com/Dirli/contract-archive/archive/v${PV}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	app-arch/file-roller
	pantheon-extra/contractor
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

src_prepare() {
	eapply_user
}

