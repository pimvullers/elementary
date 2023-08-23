# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="The Inter font family"
HOMEPAGE="https://rsms.me/inter/"
SRC_URI="https://github.com/rsms/${PN}/releases/download/v${PV}/Inter-${PV}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64"

DEPEND="app-arch/unzip"

S=${WORKDIR}
FONT_S="${S}/InterDesktop"
FONT_SUFFIX="otf"

# It's necessary to remove the space in the FONT_S directory name.
src_prepare() {
	mv "Inter Desktop" "InterDesktop" || die
	default
}
